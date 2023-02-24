# Integrant REPL

Integrant REPL includes functions to start, stop and restart services during development, enabling changes to the system without restarting the REPL process.

`(go)`, `(reset)` and `(stop)` functions are evaluated in the REPL to control the system.

To assist debugging, `(config)` displays the parsed system configuration, `(system)` shows how the configuration has being resolved (service references, profiles, etc.).  This is especially useful when using aero and environment variables.

??? HINT "Integrant REPL and Integrant"
    Integrant and Integrant REPL can share the same system configuration file, although they are otherwise separate ways of working with a system.

    Integrant is used to start a system in a consistent order and gracefully shutdown the system on a termination message, e.g. `SIGTERM`.

    Integrant REPL is additionally used to restart the services during development, loading all code changes into the REPL (especially useful after ranaming functions and namespaces)


## Integrant configuration

Define the configuration for each part of the system, such as http server (jetty, httpkit), router application (reitit, compojure, ring) and persistence storage (postgres, crux)

Use a shared `resources/config.edn` file with Integrant for consistency.  Or if there is significant experimentation to be done, create a `dev/resources/config.edn` file

```clojure title="resources/config.edn"
{:practicalli.gameboard.service/http-server
 {:handler #ig/ref :practicalli.gameboard.service/router
  :port  8888
  :join? false}

 :practicalli.gameboard.service/router
 {:persistence #ig/ref :practicalli.gameboard.service/relational-store}

 :practicalli.gameboard.service/relational-store
 {:connection  {:url "http://localhost/" :port 57207 :database "gameboard"}}}
```

Fully qualified keywords, e.g. domain.service.name/component, are used so that keys are unique throughout the system.

The fully qualified name is the namespace that contains the `defmethod init-key` for the key.  The Integrant `load-namespaces` function will automatically load all namespaces that match key names


## User namespace

Common practice is to place the Integrant REPl code in a `user` namespace, which is automatically loaded when the REPL process starts.

The `user` namespace is defined separately from the source code, as it is code to develop the service rather than part of the service itself.  The user namespace is added to the `dev/user.clj` file and added to the classpath via an alias, e.g. `:env/dev` or `:repl/reloaded` aliases from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/)

```clojure title="dev/user.clj"
(ns user
  (:require
   ;; REPL workflow
   [integrant.repl       :as ig-repl]
   [integrant.repl.state :as ig-state]

   ;; Environment parsing
   [aero.core :as aero]

   ;; Utilities
   [clojure.pprint :as pprint]))
```

[Practicalli REPL Startup - detailed examples](https://practical.li/clojure/clojure-cli/repl-startup/){target=_blank .md-button}

[Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/){target=_blank} aliases defines aliases that include the `dev` directory that contains the `user` namespace on the class path

=== "REPL Reloaded"
    `:dev/reloaded` alias starts a rich terminal REPL prompt, with the `dev` path and several tools to [enhance the REPL workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/)
    ```bash
    clojure -M:repl/reloaded
    ```

=== "Dev Tools"
    `:dev/reloaded` alias adds the `dev` path and several tools to [enhance the REPL workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/)
    ```bash
    clojure -M:dev/reloaded:repl/rebl
    ```

=== "Path"
    `:env/dev` alias adds the `dev` path on REPL start up, include the `dev/user.clj` file
    ```bash
    clojure -M:env/dev:repl/rebl
    ```


## Environment Configuration

Using aero with the Integrant configuration file includes tag literals that need to be resolved.

```clojure
;;;; Aero environment management

;; extra reader tag for Integrant references
(defmethod aero/reader 'ig/ref
  [_ tag value]
  (ig/ref value))

(defn aero-config
  "Profile specific configuration for all services.
  Profiles supported: :develop :stage :live"
  [profile]
  (aero/read-config (io/resource "config.edn") {:profile profile}))

(defn aero-prep
  "Parse the system config and update values for the given profile (:develop, :stag :live)
  Top-level keys in the config.edn use a qualified name of the Clojure namespace the ig/init-key defmethod is defined in
  ig/load-namespaces will automatically load each namespace referenced by a top-level key in the Integrant configuration
  Return: configuration hash-map for the specified profile (:develop :stage :live)"
  [profile]
  (let [config (aero-config profile)]
    (ig/load-namespaces config)
    config))
```

## Parse Configuration

```clojure
(defn integrant-prep!
  "Parse system configuration with aero-reader and apply the given profile values
  Return: Integrant configuration to be used to start the system

  integrant.repl/set-prep! takes an anonymous function that returns an integrant configuration

  Arguments: profile - a keyword determining the environment - :develop :test :stage :live"

  [profile]
  (ig-repl/set-prep!
   #(aero-prep profile)))
```


## REPL convenience functions

```clojure
(defn go
  "Prepare configuration and start the system services with Integrant-repl"
  ([] (go :develop))
  ([profile] (integrant-prep! profile) (ig-repl/go)))

(defn reset
  "Read updates from the configuration and restart the system services with Integrant-repl"
  ([] (reset :develop))
  ([profile] (integrant-prep! profile) (ig-repl/reset)))

(defn reset-all
  "Read updates from the configuration and restart the system services with Integrant-repl"
  ([] (reset-all :develop))
  ([profile] (integrant-prep! profile) (ig-repl/reset-all)))

(defn stop
  "Shutdown all services"
  [] (ig-repl/halt))

(defn system
  "The running system configuration"
  [] ig-state/system)

(defn config
  "The current system configuration used by Integrant"
  [] ig-state/config)
```

## REPL Commands

```clojure
(comment
  ;; Prepare and start the system using the :develop profile or specify the environment
  (go)
  (go :test)

  ;; Reload changed and new source code files and restart the system
  (reset)
  (reset :develop)

  ;; Reload all source code files on the Classpath and restart the system
  (reset-all)
  (reset-all :develop)

  ;; Return the current Integrant configuration (already parsed by environment)
  (config)

  ;; Show the running system configuration, returns nil when system not running
  (system)

  ;; Shutdown the system using the app-server object reference in the Integrant state
  (stop)

  ;; Pretty print the system state in the REPL
  (pprint/pprint ig-state/system)

  #_()) ;; End of rich comment block
```


??? EXAMPLE "requiring-resolve for Just In Time requires"
    [Integrant in practice](https://lambdaisland.com/blog/2019-12-11-advent-of-parens-11-integrant-in-practice){target=_blank} provides an example of using `requiring-resolve` to avoid including all requires in the `ns` form, potentially reducing REPL startup time by not adding library

    When calling an Integrant function, `requiring-resolve` returns the name of the symbol if already available in the REPL, or requires the functions namespace if the function is not available.

    The library containing the namespace must be part of the class path when the REPL starts (or library has been hotloaded into the REPL)
    ```clojure
    (ns user
      "Reduce REPL startup time by not including requires")

    (defmacro jit
      "Resolve a symbol name and require its namespace if not currently available in the REPL"
      [qualified-symbol]
      `(requiring-resolve '~qualified-symbol))

    (defn set-prep! []
      ((jit integrant.repl/set-prep!) #((jit feralberry.system/prep) :dev)))

    (defn go []
      (set-prep!)
      ((jit integrant.repl/go)))

    (defn reset []
      (set-prep!)
      ((jit integrant.repl/reset)))

    (defn system []
      @(jit integrant.repl.state/system))

    (defn config []
      @(jit integrant.repl.state/config))
    ```
