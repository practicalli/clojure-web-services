# Integrant REPL

<!-- > #### TODO: Integrant repl Review -->

Start and restart services quickly and easily from within the REPL with Integrant REPL.

Integrant REPL is for developing a system using a reloaded REPL workflow and is a separate Library and intent to that of Integrant, which is aimed at the lifecycle of running a system.

Reloaded REPL provides a simple way to reload changes into the system as it is being developed. Simple `(go)`, `(reset)` and `(stop)` commands are used with the REPL to control the system.

To assist with debugging, the parsed configuration, `(config)`, and system configuration, `(system)`, data can be viewed via the REPl state to understand how the configuration is being resolved.  This is especially useful when using aero and environment variables.

> #### Hint::Integrant REPL and Integrant
> Although Integrant and Integrant REPL can share the same configuration file, they are otherwise separate ways of working with a system.
> Integrant is used to start a system in a consistent order and gracefully shutdown the system on a termination message, e.g. `SIGTERM`.  The state of the running system in Integrant is supposed to be a hidden concern.


## Integrant configuration

Define the configuration for each part of the system, such as http server (jetty, httpkit), router application (reitit, compojure, ring) and persistence storage (postgres, crux)

Create a `develop/resources/config.edn` file containing the Integrant REPL configuration (or use aero with `resources/config.edn` file and share the configuration with Integrant)

```clojure
{:practicalli.scoreboard.service/http-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :port  8888
  :join? false}

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/relational-store}

 :practicalli.scoreboard.service/relational-store
 {:connection  {:url "http://localhost/" :port 57207 :database "scoreboard"}}}
```

Clojure encourages fully qualified keywords, i.e. domain/key, so that keys are unique throughout the system.

The domain used for integrant is the Clojure namespace that contains the defmethod init-key for the key.  The Integrant `load-namespaces` function will automatically load all namespaces that match key names


## Aero Tag Literals

The same configuration can be used that starts the system using profiles, or a separate develop profile can be created.

Aero uses [tag literals](https://github.com/juxt/aero#tag-literals) as placeholders for environment specific values

* `#profile` - replace with the value from the given profile name
* `#or`  - a vector of possible values, returning the first "truthy" value
* `#long` - cast a String value to a Clojure Long type (e.g. for PORT values)

```clojure
{:practicalli.scoreboard.service/http-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :port #profile {:develop #long #or [#env APP_SERVER_PORT 8888]
                  :test    #long #or [#env APP_SERVER_PORT 8080]
                  :stage   #long #or [#env APP_SERVER_PORT 8080]
                  :live    #long #or [#env APP_SERVER_PORT 8000]}
  :join? false}

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/relational-store}

 :practicalli.scoreboard.service/relational-store
 {:connection #profile {:develop  {:url "http://localhost/" :port 57207 :database "scoreboard-develop"}
                        :test     {:url "http://localhost/" :port 57207 :database "scoreboard-test"}
                        :stage    {:url "http://localhost/" :port 57207 :database "scoreboard-stage"}
                        :live     {:url "http://localhost/" :port 57207 :database "scoreboard"}}}}
```


## User namespace

Common practice is to place the Integrant REPl code in a `user` namespace, which is automatically loaded when the REPL process starts.

The `user` namespace is defined separately from the source code, as it is code to manage the application rather than part of the application itself.  The user namespace is added to the `develop/user.clj` file and added to the classpath when developing.

```clojure
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


## Managing the classpath

Run a REPL process including the `user` namespace on the classpath.  Also include a rich terminal UI with `:repl/rebl` alias

```bash
clojure -M:env/develop:repl/rebl
```

<!-- TODO: Integrant REPL - add repl startup screenshot ?? -->


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
