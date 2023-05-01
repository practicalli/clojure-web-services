# Donut System

!!! WARNING "Draft page"
    This is an early draft of using Donut to manage system components, although all the code does work when added to a project created with [Practicalli Project Templates](https://github.com/practicalli/project-templates/) - `practicalli/service` template.  Some of the writing and examples may be improved as more is learned about Donut


[Donut system](https://github.com/donut-party/system) takes a system as data approach, using a hash-map to define the overall system with keys to define each component (or component group) in that system.

Component definitions are also a hash-map with `:start`, `:stop`, `:config` keys to express how to manage that component

??? WARNING "Practicalli uses ::donut alias instead of ::ds"
    Practicalli requires the donut qualified keywords using `donut` rather than the more cryptic `ds`

    Practicalli recommends meaningful alias names or not using an alias at all, instead requiring specific functions.  This makes code easier to read and searching  considerably easier (fewer false matches)



> Donut system configuration is a similar approach to that used by reitit for http request routing.


## Including Donut

Donut library includes a REPL workflow namespace, so there is only one library dependency to add to the project.  This project must be included at runtime so should be added to the project `deps.edn` configuration

!!! EXAMPLE "Donut dependency in Gameboard project"
    ```clojure title="deps.edn"
    {
    :paths
     ["src" "resources"]

     :deps
     {;; Service
      http-kit/http-kit {:mvn/version "2.6.0"}  ; latest "2.7.0-alpha1"
      metosin/reitit    {:mvn/version "0.5.13"}

      ;; Logging
      com.brunobonacci/mulog             {:mvn/version "0.9.0"}
      com.brunobonacci/mulog-adv-console {:mvn/version "0.9.0"}

      ;; System
      aero/aero           {:mvn/version "1.1.6"}
      party.donut/system {:mvn/version "0.0.202"}
      org.clojure/clojure {:mvn/version "1.12.0"}}}
    ```


## Define a System

Donut defines a system using a Clojure hash-map with the following top level keys

- `::donut/defs` to define components of a system or component group
- `::donut/signals` customise the startup/shutdown approach (optional)


Create a `system` namespace to define the donut system


!!! EXAMPLE "Require libraries in the namespace form"
    ```clojure

    (ns practicalli.gameboard.system
      (:require
       ;; Application dependencies
       [practicalli.donoughty.router :as router]

       ;; System dependencies
       [org.httpkit.server     :as http-server]
       [com.brunobonacci.mulog :as mulog]
       [donut.system           :as donut]
       [aero.core              :as aero]
       [clojure.java.io        :as io]))
    ```

Define a system that runs a web server with event log publisher

The http server use the `:env` environment to determine the port, although this could be defined directly in the :http :server :config section.

There is a relationship inside the http component between server and handler.  The handler depends on configuration within the `:env` environment configuration.

The `:instance` key is associated with the component reference that is returned when a component is started.  The :instance reference is used to shut down the service.

The event log publisher and http service have no intrinsic relationship, so order of startup is not an issue as any mulog events created are cached until the publisher has started.

!!! EXAMPLE "Simple Web Service"
    ```clojure title="src/practicalli/gameboard/system.clj"
    (def system
      "System Component management with Donut"
      {::donut/defs
       {:env  {:http-port 8080
               :persistence {:database-host (System/getenv "POSTGRES_HOST")
                             :database-port (System/getenv "POSTGRES_PORT")
                             :database-username (System/getenv "POSTGRES_USERNAME")
                             :database-password (System/getenv "POSTGRES_PASSWORD")
                             :database-schema (System/getenv "POSTGRES_SCHEMA")}}
        :event-log {:publisher
                    #::donut{:start (fn mulog-publisher-start
                                      [{{:keys [dev]} ::donut/config}]
                                      (mulog/start-publisher! dev))
                             :stop (fn mulog-publisher-stop
                                     [{::donut/keys [instance]}]
                                     (instance))
                             :config {:dev {:type :console :pretty? true}}}}
        :http {:server
               #::donut{:start (fn http-kit-run-server
                                 [{{:keys [handler options]} ::donut/config}]
                                 (http-server/run-server handler options))
                        :stop  (fn http-kit-stop-server
                                 [{::donut/keys [instance]}]
                                 (instance))
                        :config {:handler (donut/local-ref [:handler])
                                 :options {:port  (donut/ref [:env :http-port])
                                           :join? false}}}
               :handler (router/app (donut/ref [:env :persistence]))}}})
    ```


## Start the system

Use `donut/signal` with the `::donut/start` key to start all the components in the system.

> `::donut/signals` key is associated with a signal configuration to modify the start and stop process, although the default process should work in most cases.

Define a `-main` function in the main namespace of the service, e.g `practicalli.gameboard.service`

The `-main` function starts the Donut system and keeps the system reference as a local name

The system reference is used to shutdown the system, typically wrapped in code to handle SIGTERM signals from the infrastructure running the service (Operating system, Kubernettes, EC2, etc.)



!!! EXAMPLE "Start a Donut system"
    ```clojure
    (defn -main
      "practicalli service managed by donut system,
      Aero is used to configure Integrant configuration based on profile (dev, test, prod),
      allowing environment specific configuration, e.g. mulog publisher
      The shutdown hook gracefully stops the service on receipt of a SIGTERM from the infrastructure,
      giving the application 30 seconds before forced termination."
      []

      (mulog/set-global-context!
       {:app-name "practicalli donoughty service" :version  "0.1.0"})

      (mulog/log ::gameboard-system :system-config system/config)

      (let [running-system (donut/signal system/system ::donut/start)]
           (.addShutdownHook
             (Runtime/getRuntime)
             (Thread. ^Runnable #(donut/signal running-system ::donut/stop)))))
    ```
    Mulog event logging is included and the system should start a mulog publisher via the system configuration


## Service REPL Workflow

`donut.system.repl` namespace provides functions to start, stop and restart system components.

The main system configuration used when starting the service can also be used for the REPL, or other named systems can be defined allowing for a customised system during development.


!!! EXAMPLE "Service REPL workflow"
    ```clojure
    (ns system-repl
      "Tools for REPL Driven Development"
      (:require
       [donut.system :as donut]
       [donut.system.repl :as donut-repl]
       [practicalli.donoughty.system :as donoughty]
       [com.brunobonacci.mulog :as mulog]))

    (defmethod donut/named-system :donut.system/repl
      [_] donoughty/main)

    (defn start
      "Start system with donut, optionally passing a named system"
      ([] (donut-repl/start))
      ([system-config] (donut-repl/start system-config)))

    (defn stop
      "Stop the currently running system"
      []  (donut-repl/stop))

    (defn restart
      "Restart the system with donut repl,
      Uses clojure.tools.namespace.repl to reload namespaces
      `(clojure.tools.namespace.repl/refresh :after 'donut.system.repl/start)`"
      [] (donut-repl/restart))
    ```
