# Integrant REPL

[Integrant REPL](integrant-repl.md) is a library to manage components as part of a REPL workflow, to extend features provided by Integrant.

Integrant REPL includes functions to start, stop and restart services during development, enabling changes to the system without restarting the REPL process.

`(start)`, `(reset)` and `(stop)` functions are evaluated in the REPL to control the system.

To assist debugging, `(config)` displays the parsed system configuration and `(system)` shows how the configuration has being resolved (service instances, profile values, etc.).  Viewing the live system configuration is especially useful when using aero and environment variables to confirm the expected values are used.


## User namespace

Common practice is to place the Integrant REPl code in a `user` namespace, which is automatically loaded when the REPL process starts.

The `user` namespace is defined separately from the source code, as it is code to develop the service rather than part of the service itself.  The user namespace is added to the `dev/user.clj` file and added to the classpath via an alias, e.g. `:env/dev` or `:repl/reloaded` aliases from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/)

!!! EXAMPLE "Custom user namespace"
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
    `:repl/reloaded` alias starts a rich terminal REPL prompt, with the `dev` path and several tools to [enhance the REPL workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/)
    !!! NOTE ""
        ```bash
        clojure -M:repl/reloaded
        ```

=== "Dev Tools"
    `:dev/reloaded` alias adds the `dev` path and several tools to [enhance the REPL workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/)
    !!! NOTE ""
        ```bash
        clojure -M:dev/reloaded:repl/rebl
        ```

=== "Path"
    `:env/dev` alias adds the `dev` path on REPL start up, include the `dev/user.clj` file
    !!! NOTE ""
        ```bash
        clojure -M:env/dev:repl/rebl
        ```


## Environment Configuration

Using aero with the Integrant configuration file includes tag literals that need to be resolved.

!!! EXAMPLE "Parsing Aero tags in Integrant system configuration"
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

!!! EXAMPLE "Parsing Integrant system configuration"
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

!!! EXAMPLE "REPL convenience functions"
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

!!! EXAMPLE "REPL commands"
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
