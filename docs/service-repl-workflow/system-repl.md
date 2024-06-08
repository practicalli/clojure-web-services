# System REPL workflow

`dev/system_repl.clj` file provides functions to `start`, `stop` and `restart` the components in the Clojure system.  This functions are required into the custom `user` namespace (`dev/user.clj`).


Practicalli Project templates creates a `dev/system_repl.clj` with one of the following approaches

- (default) Atom reference to restart http server and refresh namespaces
- `:component :donut` provides a donut-party/system definition and component management functions, including refresh namepaces
- `:component :integrant` provides Integrant REPL: Integrant REPL using Integrant system definition and component management functions, including refresh namepaces


=== "Atom"
    A reference to the http server started by http-kit is held in a Clojure atom named `http-server-reference`.  The reference can be used to stop the http server without requiring a restart of the Clojure REPL.

    !!! EXAMPLE "System REPL - Atom based Restart"    

        ```clojure
        ;; ---------------------------------------------------------
        ;; System REPL - Atom Restart 
        ;;
        ;; Tools for REPl workflow with Aton reference to HTTP server 
        ;; https://practical.li/clojure-web-services/app-servers/simple-restart/
        ;; ---------------------------------------------------------

        (ns system-repl
          (:require 
            [clojure.tools.namespace.repl :refer [refresh]]
            [practicalli.todo-tracker.service :as service]))
                    
        ;; ---------------------------------------------------------
        ;; HTTP Server State

        (defonce http-server-instance (atom nil))
        ;; ---------------------------------------------------------


        ;; ---------------------------------------------------------
        ;; REPL workflow commands

        (defn stop
          "Gracefully shutdown the server, waiting 100ms"
          []
          (when-not (nil? @http-server-instance)
            (@http-server-instance :timeout 100)
            (reset! http-server-instance nil)
            (println "INFO: HTTP server shutting down...")))

        (defn start
          "Start the application server and run the application"
          [& port]
          (let [port (Integer/parseInt
                      (or (first port)
                          (System/getenv "PORT")
                          "8080"))]
            (println "INFO: Starting server on port:" port)

            (reset! http-server-instance
                    (service/http-server-start port))))


        (defn restart
          "Stop the http server, refresh changed namespace and start the http server again"
          []
          (stop)
          (refresh)  ;; Refresh changed namespaces
          (start))
        ;; ---------------------------------------------------------
        ```

=== "Donut System"

    donut-party/system is a data-centric configuration that includes functions to `:start` and `:stop` each component.

    `dev/service_repl.clj` defines functions to manage the components defined in the Clojure system

    - `start` the components, optionally passing a named system
    - `stop` components in the currently running system
    - `restart` stops components, reloads namespaces and starts components
    - `system` returns a hash-map of currently running system state


    !!! EXAMPLE "Donut System REPL functions"
        ```clojure
        ;; ---------------------------------------------------------
        ;; Donut System REPL
        ;;
        ;; Tools for REPl workflow with Donut system components
        ;; ---------------------------------------------------------

        (ns system-repl
          "Tools for REPl workflow with Donut system components"
          (:require
           [donut.system :as donut]
           [donut.system.repl :as donut-repl]
           [donut.system.repl.state :as donut-repl-state]
           [practicalli.todo-donut.system :as system]))


        (defmethod donut/named-system :donut.system/repl
          [_] system/main)

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

        (defn system
          "Return: fully qualified hash-map of system state"
          [] donut-repl-state/system)
        ```


    !!! EXAMPLE "Donut System configuration"
        ```clojure
        ;; ---------------------------------------------------------
        ;; practicalli.todo-donut
        ;;
        ;; TODO: Provide a meaningful description of the project
        ;;
        ;; Start the service using donut configuration and an environment profile.
        ;; ---------------------------------------------------------

        (ns practicalli.todo-donut.system
          "Service component lifecycle management"
          (:gen-class)
          (:require
           ;; Application dependencies
           [practicalli.todo-donut.router :as router]

           ;; Component system
           [donut.system :as donut]
           ;; [practicalli.todo-donut.parse-system :as parse-system]

           ;; System dependencies
           [org.httpkit.server     :as http-server]
           [com.brunobonacci.mulog :as mulog]))

        ;; ---------------------------------------------------------
        ;; Donut Party System configuration

        (def main
          "System Component management with Donut"
          {::donut/defs
           ;; Option: move :env data to resources/config.edn and parse with aero reader
           {:env
            {:http-port 8080
             :persistence
             {:database-host (or (System/getenv "POSTGRES_HOST") "http://localhost")
              :database-port (or (System/getenv "POSTGRES_PORT") "5432")
              :database-username (or (System/getenv "POSTGRES_USERNAME") "clojure")
              :database-password (or (System/getenv "POSTGRES_PASSWORD") "clojure")
              :database-schema (or (System/getenv "POSTGRES_SCHEMA") "clojure")}}

            ;; mulog publisher for a given publisher type, i.e. console, cloud-watch
            :event-log
            {:publisher
             #::donut{:start (fn mulog-publisher-start
                               [{{:keys [publisher]} ::donut/config}]
                               (mulog/log ::log-publish-component
                                          :publisher-config publisher
                                          :local-time (java.time.LocalDateTime/now))
                               (mulog/start-publisher! publisher))

                      :stop (fn mulog-publisher-stop
                              [{::donut/keys [instance]}]
                              (mulog/log ::log-publish-component-shutdown :publisher instance :local-time (java.time.LocalDateTime/now))
                              ;; Pause so final messages have chance to be published
                              (Thread/sleep 250)
                              (instance))

                      :config {:publisher {:type :console :pretty? true}}}}

            ;; HTTP server start - returns function to stop the server
            :http
            {:server
             #::donut{:start (fn http-kit-run-server
                               [{{:keys [handler options]} ::donut/config}]
                               (mulog/log ::http-server-component
                                          :handler handler
                                          :port (options :port)
                                          :local-time (java.time.LocalDateTime/now))
                               (http-server/run-server handler options))

                      :stop  (fn http-kit-stop-server
                               [{::donut/keys [instance]}]
                               (mulog/log ::http-server-component-shutdown
                                          :http-server-instance instance
                                          :local-time (java.time.LocalDateTime/now))
                               (instance))

                      :config {:handler (donut/local-ref [:handler])
                               :options {:port  (donut/ref [:env :http-port])
                                         :join? false}}}

             ;; Function handling all requests, passing system environment
             ;; Configure environment for router application, e.g. database connection details, etc.
             :handler (router/app (donut/ref [:env :persistence]))}}})

        ;; End of Donut Party System configuration
        ;; ---------------------------------------------------------
        ```



=== "Integrant REPL"

    Integrant REPL manages Integrant components from the REPL.

    Practicalli uses Integrant configuration, `resources/config.edn` also used by the service when deployed or otherwise calling the `-main` function of the service.

    !!! EXAMPLE "Integrant REPL functions"

        ```clojure
        ;; ---------------------------------------------------
        ;; System component management for REPL workflow
        ;;
        ;; System config components defined in `resources/config.edn`
        ;;
        ;; `system` namespace automatically loaded via the `dev/user.clj` namespace
        ;;
        ;; Commands:
        ;; `(start)` starts all components in system config
        ;; `(restart)` reads system config, reloads changed namespaces & restarts system
        ;; `(restart-all)` as above with all namespaces reloaded
        ;; `(stop)` shutdown all components in the system (gracefully where appropriate)
        ;; `(system)` show configuration of the running system
        ;; `(config)` system configuration
        ;;
        ;; NOTE: standard IntegrantREPL code, maintenance should not be required
        ;; ---------------------------------------------------

        (ns system-repl
          "Configure the system components and provide Integrant REPL convenience functions
          to start/stop/restart components and show system configuration"
          (:require
           ;; REPL workflow
           [integrant.repl       :as ig-repl]
           [integrant.repl.state :as ig-state]
           [clojure.pprint :as pprint]

           [practicalli.todo-integrant.parse-system :as parse-system]))

        (println "Loading system namespace for Integrant REPL")


        ;; ---------------------------------------------------------
        ;; System Configuration
        ;; - `resources/config.edn` Integrant & Aero system configuration

        (defn environment-prep!
          "Parse system configuration with aero-reader and apply the given profile values
          Return: Integrant configuration to be used to start the system
          integrant.repl/set-prep! takes an anonymous function that returns an integrant configuration
          Arguments: profile - a keyword determining the environment - :dev :test :stage :live"

          [profile]
          (ig-repl/set-prep! #(parse-system/aero-prep profile)))

        ;; ---------------------------------------------------------


        ;; ---------------------------------------------------------
        ;; Integrant REPL convenience functions
        ;; - enable use of aero profiles (`dev`, `stage`, `prod`)
        ;; - simplify Integrant REPL commands for managing the system

        (defn start
          "Prepare configuration and start the system services with Integrant-repl"
          ([] (start :dev))
          ([profile] (environment-prep! profile) (ig-repl/go)))


        (defn restart
          "Read updates from the system configuration, reloads changed namespaces
          and restart the system services with Integrant-repl"
          ([] (restart :dev))
          ([profile] (environment-prep! profile) (ig-repl/reset)))


        (defn restart-all
          "Read updates from the configuration, reloads all namespaces
          and restart the system services with Integrant-repl"
          ([] (restart-all :dev))
          ([profile] (environment-prep! profile) (ig-repl/reset-all)))


        (defn stop
          "Shutdown all services"
          []
          (ig-repl/halt))


        (defn system
          "The running system configuration,
          including component references and specific profile values"
          []
          ig-state/system)


        (defn config
          "The current system configuration used by Integrant"
          []
          (pprint/pprint ig-state/config))

        ;; End of Integrant REPL convenience functions
        ;; ---------------------------------------------------------
        ```


    !!! EXAMPLE "Integrant System configuration"

        ```clojure
        ;; --------------------------------------------------
        ;; System Component configuration - Integrant & Integrant REPL
        ;;
        ;; - Event logging (mulog)
        ;; - HTTP Server  (embedded jetty or http-kit)
        ;; - Request routing (reitit)
        ;; - Persistence (relational) connection
        ;;
        ;; Components managed in practicalli.todo-integrant.system namespace
        ;;
        ;; #profile used by aero to select the configuration to use for a given profile (dev, test, prod)
        ;; #long defines Long Integer type (required for Java HTTP server port)
        ;; #env reads the environment variable of the given name
        ;; #or uses first non nil value in sequence
        ;;
        ;; Environment variables should be defined locally and in deployment provisioner tooling
        ;; --------------------------------------------------


        {;; --------------------------------------------------
         ;; Event logging service - mulog

         ;; https://github.com/BrunoBonacci/mulog#publishers
         ;; https://github.com/openzipkin/zipkin
         :practicalli.todo-integrant.system/log-publish
         {;; Type of publisher to use for mulog events
          ;; Publish json format logs, captured by fluentd and exposed via OpenDirectory
          :mulog #profile {:dev  {:type :console-json :pretty? true}

                           ;; Multiple publishers using Open Zipkin service (started via docker-compose)
                           :docker  {:type :multi
                                     :publishers
                                     [{:type :console-json :pretty? false}
                                      {:type :zipkin :url "http://localhost:9411/"}]}

                           :prod {:type :console-json :pretty? false}}}

         ;; --------------------------------------------------
         ;; HTTP Server - embedded service

         :practicalli.todo-integrant.system/http-server
         {;; Router function passed into the HTTP server form managing requests/responses
          :handler #ig/ref :practicalli.todo-integrant.system/router

          ;; Port number (Java Long type) - environment variable or default number
          :port  #long #or [#env HTTP_SERVER_PORT 8080]

          ;; Join REPL to HTTP server thread
          :join? false}

         ;; --------------------------------------------------
         ;; persistence - connection to relational storage

         ;; TODO: add database connection pool ?

         :practicalli.todo-integrant.system/relational-store
         {:host #or [#env DATABASE_HOST "localhost"]
          :port #or [#env DATABASE_PORT 3306]
          :username #or [#env DATABASE_USERNAME "gameboard"]
          :password #or [#env DATABASE_PASSWORD "trustnoone"]}

         ;; --------------------------------------------------
         ;; Data provider services
         ;; - connection to services that provide eSports data

         :practicalli.todo-integrant.system/data-provider
         {;; external data providers
          :game-service-base-url  #or [#env GAME_SERVICE_BASE_URL "http://localhost"]
          :llamasoft-api-uri  #or [#env LAMASOFT_API_URI "http://localhost"]
          :polybus-report-uri "/report/polybus"
          :moose-life-report-uri "/api/v1/report/moose-life"
          :minotaur-arcade-report-uri "/api/v2/minotar-arcade"
          :gridrunner-revolution-report-uri "/api/v1.1/gridrunner"
          :space-giraffe-report-uri "/api/v1/games/space-giraffe"}

         ;; --------------------------------------------------
         ;; routing

         ;; Configure web routing application with application environment
         ;; define top-level keys to access via the environment hash-map
         ;; - :persistence - database connection information
         ;; - :data-provider - url, endpoint, tokens for external services 
         :practicalli.todo-integrant.system/router
         {:persistence #ig/ref :practicalli.todo-integrant.system/relational-store
          :data-provider #ig/ref :practicalli.todo-integrant.system/data-provider}}
        ```


    !!! EXAMPLE "Integrant System components"

        ```clojure
        ;; ---------------------------------------------------------
        ;; practicalli.todo-integrant
        ;;
        ;; TODO: Provide a meaningful description of the project
        ;;
        ;; Start the service using Integrant configuration and an environment profile.
        ;; A profile is injected into the configuration in the `practicalli.gameboard.environment` namespace
        ;; and the resulting configuration is used by Integrant to start the system components
        ;;
        ;; The service consist of
        ;; - httpkit web application server
        ;; - metosin/reitit for routing and ring for request / response management
        ;; - mulog event logging service
        ;;
        ;; Related namespaces
        ;; `resources/config.edn` system configuration with environment #profile placeholders
        ;; `practicalli.environment` injects profile & other aero tag values into a resulting configuration
        ;; ---------------------------------------------------------

        (ns practicalli.todo-integrant.system
          "Service component lifecycle management"
          (:gen-class)
          (:require
           ;; Application dependencies
           [practicalli.todo-integrant.router :as router]

           ;; Component system
           [practicalli.todo-integrant.parse-system :as parse-system]

           ;; System dependencies
           [org.httpkit.server     :as http-server]
           [integrant.core         :as ig]
           [com.brunobonacci.mulog :as mulog]))

        ;; --------------------------------------------------
        ;; Configure and start application components

        (defn initialise
          "initialise the system using Integrant"
          [profile]
          (ig/init (parse-system/aero-prep profile)))

        ;; Start mulog publisher for the given publisher type, i.e. console, cloud-watch
        #_{:clj-kondo/ignore [:unused-binding]}
        (defmethod ig/init-key ::log-publish
          [_ {:keys [mulog] :as config}]
          (mulog/log ::log-publish-component :publisher-config mulog :local-time (java.time.LocalDateTime/now))
          (let [publisher (mulog/start-publisher! mulog)]
            publisher))

        ;; Connection for Relational Database Persistence
        ;; return hash-map of connection values: endpoint, access-key, secret-key
        ;; TODO: add example of connection pool
        (defmethod ig/init-key ::relational-store
          [_ {:keys [connection] :as config}]
          (mulog/log ::persistence-component :connection connection :local-time (java.time.LocalDateTime/now))
          config)

        ;; Connections for data services
        (defmethod ig/init-key ::data-provider
          [_ config]
          (mulog/log ::data-provider-component :configuration config :local-time (java.time.LocalDateTime/now))
          config)

        ;; Configure environment for router application, e.g. database connection details, etc.
        (defmethod ig/init-key ::router
          [_ config]
          (mulog/log ::app-routing-component :app-config config)
          (router/app config))

        ;; HTTP server start - returns function to stop the server
        (defmethod ig/init-key ::http-server
          [_ {:keys [handler port join?]}]
          (mulog/log ::http-server-component :handler handler :port port :local-time (java.time.LocalDateTime/now))
          (http-server/run-server handler {:port port :join? join?}))

        ;; Shutdown HTTP service
        (defmethod ig/halt-key! ::http-server
          [_ http-server-instance]
          (mulog/log ::http-server-component-shutdown  :http-server-object http-server-instance :local-time (java.time.LocalDateTime/now))
          ;; Calling http instance shuts down that instance
          (http-server-instance))

        ;; Shutdown Log publishing
        (defmethod ig/halt-key! ::log-publish
          [_ publisher]
          (mulog/log ::log-publish-component-shutdown :publisher-object publisher :local-time (java.time.LocalDateTime/now))
          ;; Pause so final messages have chance to be published
          (Thread/sleep 250)
          ;; Call publisher again to stop publishing
          (publisher))

        (defn stop
          "Stop service using Integrant halt!"
          [system]
          (mulog/log ::http-server-sigterm :system system :local-time (java.time.LocalDateTime/now))
          ;; (println "Shutdown of service via Integrant")
          (ig/halt! system))

        ;; --------------------------------------------------
        ```
