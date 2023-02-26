# Integrant Component Lifecycle

Use a data configuration to start and stop components of a system effectively.

??? WARNING "Draft page - more explination to follow"


## Prepare system

Use prep function to load namespaces into the REPL.

```clojure title="Prepare system confige and load namespaces"
(defn aero-prep
  "Parse the system config and update values for the given profile (:dev, :test :prod)
  Top-level keys in `config.edn` use fully qualified namespace name for `ig/init-key` defmethod
  `ig/load-namespaces` automatically loads each namespace referenced by a top-level key
  Return: configuration hash-map for specified profile (:dev :test :prod) with aero tags resolved"
  [profile]
  (let [config (aero-config profile)]
    ;; (mulog/log ::integrant-load-namespaces :config config :local-time (java.time.LocalDateTime/now)
    (ig/load-namespaces config)
    config))
```


## Initialise Components

Define how components are initialised (started and/or configured)


## Start mulog publisher

Start mulog publisher for the given publisher type, i.e. console, cloud-watch

```clojure
(defmethod ig/init-key ::log-publish
  [_ {:keys [mulog] :as config}]
  (mulog/log ::log-publish-component :publisher-config mulog :local-time (java.time.LocalDateTime/now))
  (let [publisher (mulog/start-publisher! mulog)]
    publisher))
```

### Database Connection

Connection for a Relational Database Persistence which returns a hash-map of connection values: endpoint, access-key, secret-key

```clojure
(defmethod ig/init-key ::relational-store
  [_ {:keys [connection] :as config}]
  (mulog/log ::persistence-component :connection connection :local-time (java.time.LocalDateTime/now))
  config)
```

> TODO: add example of connection pool


### Request Router

Configure environment for router application, e.g. database connection details, etc.

```clojure
(defmethod ig/init-key ::router
  [_ config]
  (mulog/log ::app-routing-component :app-config config)
  (router/app config))
```

### HTTP Server start

HTTP server start - returns function to stop the server

```clojure
(defmethod ig/init-key ::http-server
  [_ {:keys [handler port join?]}]
  (mulog/log ::http-server-component :handler handler :port port :local-time (java.time.LocalDateTime/now))
  (http-server/run-server handler {:port port :join? join?}))
```

## shutdown Components

Define how each component should be halted (if required)

Server processes should be halted gracefully

```clojure title="Shut down all components using the Integrant system configuration"
(defn stop
  "Stop service using Integrant halt!"
  [system]
  (mulog/log ::http-server-sigterm :system system :local-time (java.time.LocalDateTime/now))
  ;; (println "Shutdown of Practicall Gameboard service via Integrant")
  (ig/halt! system))
```


### Halt HTTP server

Shutdown HTTP service

```clojure
(defmethod ig/halt-key! ::http-server
  [_ http-server-instance]
  (mulog/log ::http-server-component-shutdown  :http-server-object http-server-instance :local-time (java.time.LocalDateTime/now))
  ;; Calling http instance shuts down that instance
  (http-server-instance))
```



### Halt process gracefully

Use a Java hook that obtains details of the current JVM runtime environment and calls a Clojure `stop` function with the Integrant system configuration to stop the components.

```clojure
(.addShutdownHook (Runtime/getRuntime) (Thread. ^Runnable #(stop system)))
```

!!! HINT "Typical 30 second shutdown grace period"
    Most Cloud Infrastructure should provide 30 seconds grace period to the Clojure service to shut down before the operating system begins to shut down.

??? EXAMPLE "-main function to start and shut down an HTTP server gracefully"
   The `-main` function from the Gameboard Web Service which starts all components with a given Aero profile (`:dev` profile default).

   The `-main` function creates a `system` local name from preparing the Integrant system configuration, which is passed to the Clojure service `stop` function via an `.addShutdownHook` to gracefully shut down the services
   ```clojure
    (defn -main
      "Gameboard service is started with `ig/init` and the Integrant configuration,
      with the return value bound to the namespace level `system` name.
      Aero is used to configure Integrant configuration based on profile (dev, test, prod),
      allowing environment specific configuration, e.g. mulog publisher
      The shutdown hook calling a zero arity function, gracefully stopping the service
      on receipt of a SIGTERM from the infrastructure, giving the application 30 seconds before forced termination."
      []

      (let [profile (or (keyword (System/getenv "SERVICE_PROFILE"))
                        :dev)

            ;; Add keys to every event / publish profile use to start the service
            _ (mulog/set-global-context!
               {:app-name "Practicalli Gameboard Service" :version  "0.1.0" :env profile})

            system (ig/init (environment/aero-prep profile))

            _ (mulog/log ::gameboard-system :system-config system)]

        ;; Gracefully shutdown the HTTP server on recieving a SIGTERM
        (.addShutdownHook (Runtime/getRuntime) (Thread. ^Runnable #(stop system)))))
   ```



### Halt Event Log Publisher

The event log publisher should be the last component to be shut down to ensure all events have been captured and had time to be published.

Shutdown the mulog event publisher process, including a `(Thread/sleep 250)` to sleep the thread for 250ms to give time for all events to be published.

```clojure
(defmethod ig/halt-key! ::log-publish
  [_ publisher]
  (mulog/log ::log-publish-component-shutdown :publisher-object publisher :local-time (java.time.LocalDateTime/now))
  ;; Pause so final messages have chance to be published
  (Thread/sleep 250)
  ;; Call publisher again to stop publishing
  (publisher))
```

!!! HINT "Important to shut down the mulog publisher"
    If the mulog publisher is not shut down then multiple publishers could be run when restarting system components.  Each publisher running will publish each event, leading to events being published multiple times.

    The mulog configuration can be defined to run multiple types of publishers, which if not shut down on a system restart will publish mutltipe events to each type of publisher.

    Ensuring all types of mulog publishers are shut down will avoid this issue.

    Stoping the REPL process will also terminate any mulog publishers that were initialised.
