## Add an embedded web application server
The status monitor service runs on top of an application server which handles the infrastructure of messaging over https and other Internet protocols.

There are several libraries to provide this, ring and http-kit being the most common.


## Add dependencies for application server and routing
Edit the `deps.edn` file for the project.

Add the [http-kit library](http://http-kit.github.io/) library for the application server

Add the compojure library for routing of requests

```clojure
 :deps
 {org.clojure/clojure {:mvn/version "1.10.1"}
  http-kit            {:mvn/version "2.3.0"}
  compojure           {:mvn/version "1.6.1"}}
```


## Add code to start the application server
Edit the `src/practicalli/status_monitor_service.clj` file

Include the http-kit server namespace and the compojure core namespace as requires in the `ns` definition.

```clojure
(ns practicalli.status-monitor-service
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]))
```

Add an atom to hold a reference to the running application server.  When the server is not running, the atom contains `nil`.

```clojure
(defonce app-server-instance (atom nil))
```

Update the `-main` function to start the application server using http-kit `run-server`, optionally setting the port number the server should run on.

```clojure
(defn -main
  "Start the application server and run the application"
  [port]
  (println "INFO: Starting server on port: " port)

  (reset! app-server-instance
          (app-server/run-server #'status-monitor {:port (Integer/parseInt port)})))
```

## Define a default route and handler
Using the compojure `defroutes` function, define the default route and response when the status-monitor app received a request on the main URL, (eg. http://localhost:8888/)


```clojure
(defroutes status-monitor
  (GET "/" [] {:status 200 :body "Status Monitor Dashboard"}))
```

The route returns a hash-map that is the form of a response map. http-kit server transforms all response maps into https responses that are sent back to the requesting web browser.


## Stop and restart server from REPL
Add functions to stop and restart the server, so change to the application code can be loaded in without having to stop the Clojure REPL.

Use the value in the app-server-instance atom to determine if the app-server is already running.  If so, then send the instance the `:timeout` key with a value of time to shut itself down.

```clojure
(defn stop-app-server
  "Gracefully shutdown the server, waiting 100ms"
  []
  (when-not (nil? @app-server-instance)
    (@app-server-instance :timeout 100)
    (reset! app-server-instance nil)
    (println "INFO: Application server stopped")))
```


With a REPL running the project, the server is started calling `(-main)` and stopped by calling `(stop-app-server)`.  A restart function is simply calling the stop and start functions.

```clojure
(defn restart-app-server
  "Convenience function to stop and start the application server"
  []
  (stop-app-server)
  (-main))
```


> #### Hint::Component lifecycle service
> This approach is the essence of component lifecycle services such as [mount](https://github.com/tolitius/mount), component and [integrant](https://github.com/weavejester/integrant).
>
> Use the [mount](https://github.com/tolitius/mount) library if you are starting with component lifecycle services or require a clean and simple approach.  Try [integrant](https://github.com/weavejester/integrant) to take a data centric approach to such a service.


## REPL experiment section
To help use the code during development a comment body has been included with calls to start, stop and restart the application.

```clojure
(comment

  ;; start application
  (-main)

  ;; stop application
  (stop-app-server)

  ;; restart application
  (restart-app-server)

  )
```
