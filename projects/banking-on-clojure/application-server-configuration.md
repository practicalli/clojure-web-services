# Application server configuration
Initially the project is configured with a simple application sever using [http-kit](http://http-kit.github.io/) and routing defined by [compojure](https://github.com/weavejester/compojure) library.  The [ring](https://github.com/ring-clojure/ring) library is used to generate well-formed responses.

Add `org.httpkit.server`, `compojure` and `ring.util.response` as required namespaces

```clojure
(ns practicalli.banking-on-clojure
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]
            [ring.util.response :refer [response]]))
```

## Routing and Request handlers
`compojure` provides an abstraction for routing. The `defroutes` function directs requests to handlers, which are Clojure functions that take a request hash-map as an argument.

The routing is based on the http protocol (GET, POST, etc) and URL.

```clojure
(defn welcome-page
  [request]
  (response "Banking on Clojure"))

(defroutes app
  (GET "/" [] welcome-page))
```

## Defining the application server system
A `clojure.core/atom` is used to hold a reference to application server instance for stopping/restarting the server.

```clojure
(defonce app-server-instance (atom nil))
```

A function to start the application server on a given HTTP port number.

The start process sends a timestamped log message to standard out before starting the application server.

The `app-server-instance` is updated with a reference to the running application server.

```clojure
(defn app-server-start
  "Start the application server and log the time of start."

  [http-port]
  (println (str (java.util.Date.)
                " INFO: Starting server on port: " http-port))
  (reset! app-server-instance
          (app-server/run-server #'app {:port http-port})))
```

A function to stop the application server, send out a timestamped log message and remove the application server reference.

```clojure
(defn app-server-stop
  "Gracefully shutdown the server, waiting 100ms.  Log the time of shutdown"
  []
  (when-not (nil? @app-server-instance)
    (@app-server-instance :timeout 100)
    (reset! app-server-instance nil)
    (println (str (java.util.Date.)
                  " INFO: Application server shutting down..."))))
```

A function to restart the application server, which simply calls the stop and start functions.

```clojure
(defn app-server-restart
  "Convenience function to stop and start the application server"

  [http-port]
  (app-server-stop)
  (app-server-start http-port))
```

A `-main` function that will be called from the command line, taking an optional HTTP port.  If a port number is no provided as an argument, an operating system environment variable called PORT is used or the default `8888` is used.

Using an operating system environment variable is important when deploying the application to a cloud environment.

```clojure
(defn -main
  "Select a value for the http port the app-server will listen to
  and call app-server-start

  The http port is either an argument passed to the function,
  an operating system environment variable or a default value."

  [& [http-port]]
  (let [http-port (Integer. (or http-port (System/getenv "PORT") "8888"))]
    (app-server-start http-port)))
```

## REPL driven development helpers
A comment block is added at the end of the code to show how to start/stop/restart the web application, along with a few useful expressions.

```clojure
(comment

  ;; Start application server - via `-main` or `app-server-start`
  (-main)
  (app-server-start 8888)

  ;; Stop / restart application server
  (app-server-stop)
  (app-server-restart 8888)

  ;; Get PORT environment variable from Operating System
  (System/getenv "PORT")

  ;; Get all environment variables
  ;; use a data inspector to view environment-variables name
  (def environment-variables
    (System/getenv))

  ;; Check values set in the default system properties
  (def system-properties
    (System/getProperties))

  )
```

## The Complete code so far

```clojure
(ns practicalli.banking-on-clojure
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]
            [ring.util.response :refer [response]]))


;; Request handlers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defn welcome-page
  [request]
  (response "Banking on Clojure"))


;; Request Routing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defroutes app
  (GET "/" [] welcome-page))


;; System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Reference to application server instance for stopping/restarting
(defonce app-server-instance (atom nil))


(defn app-server-start
  "Start the application server and log the time of start."

  [http-port]
  (println (str (java.util.Date.)
                " INFO: Starting server on port: " http-port))
  (reset! app-server-instance
          (app-server/run-server #'app {:port http-port})))


(defn app-server-stop
  "Gracefully shutdown the server, waiting 100ms.  Log the time of shutdown"
  []
  (when-not (nil? @app-server-instance)
    (@app-server-instance :timeout 100)
    (reset! app-server-instance nil)
    (println (str (java.util.Date.)
                  " INFO: Application server shutting down..."))))


(defn app-server-restart
  "Convenience function to stop and start the application server"

  [http-port]
  (app-server-stop)
  (app-server-start http-port))


(defn -main
  "Select a value for the http port the app-server will listen to
  and call app-server-start

  The http port is either an argument passed to the function,
  an operating system environment variable or a default value."

  [& [http-port]]
  (let [http-port (Integer. (or http-port (System/getenv "PORT") "8888"))]
    (app-server-start http-port)))


;; REPL driven development helpers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(comment

  ;; Start application server - via `-main` or `app-server-start`
  (-main)
  (app-server-start 8888)

  ;; Stop / restart application server
  (app-server-stop)
  (app-server-restart 8888)

  ;; Get PORT environment variable from Operating System
  (System/getenv "PORT")

  ;; Get all environment variables
  ;; use a data inspector to view environment-variables name
  (def environment-variables
    (System/getenv))

  ;; Check values set in the default system properties
  (def system-properties
    (System/getProperties))

  )
```
