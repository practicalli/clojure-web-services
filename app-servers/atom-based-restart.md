# Atom based restart
A Clojure atom is used to hold a reference to a running server instance.

An atom is a mutable container that holds any type of value.  The value in the atom is immutable.  The atom is mutable, but only with specific functions, avoiding locking issues often arising with mutable values.

* `swap!` the current value in the atom using a function to create a new value
* `reset!` the current value in the atom with a specific value
* `deref` or `@` returns the value contained within the atom

{% tabs jetty="Jetty", httpkit="Http-kit Server" %}

{% content "jetty" %}
`(defonce app-server-instance (atom nil))` defines a Clojure atom with the intial value of `nil`.  `defonce` is used instead of `def` to prevent the reference to the app-server being over-written by re-evaluating the namespace.

The `-main` function determines an HTTP port value, from either an argument, an operating system `$PORT` environment variable or using the default 8888 value.

`-main` calls  `app-server-start` which starts the app server and resets the value of the atom with a reference to that instance.

`(.stop @app-server-instance)` uses the instance reference to stop the server.  `app-server-stop` function check to see if a running instance exists and if so, stops the server.

The REPL is still running, so the server can be started by calling `(-main)` or `(app-server-start 8888)`.

`app-server-restart` is a convenience function that stops and starts the application server, meaning the developer only needs to evaluate `(app-server-restart)`

## Code example

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [ring.adapter.jetty :as jetty]
            [compojure.core :refer [defroutes GET]]))

;; Routing

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System

;; Reference to server instance
(defonce app-server-instance (atom nil))


(defn app-server-start
"Start Jetty Application server, adding instance to global state"
  [port]
  (reset! app-server-instance
          (jetty/run-jetty #'app {:port port :join? false})))


(defn app-server-stop
  "Check for a running app-server instance, shutdown if present"
  []
  (when @app-server-instance
    (.stop @app-server-instance))
  (reset! app-server-instance nil))


(defn app-server-restart
  "Stop and then start the application server, loading in the new code"
  []
  (app-server-stop)
  (app-server-start (Integer. (or (System/getenv "PORT") 8888))))


(defn -main
  "Determine an HTTP port number and start application server on that port.
  A value for port can be passed as the first argument to the command to start the application via the CLI"
  [& [port]]
  (let [port (Integer. (or port
                           (System/getenv "PORT")
                           8888))]
    (app-server-start port)))


;; REPL driven development

(comment

 (app-server-restart)
 (-main)

)
```


{% content "httpkit" %}
An atom holds an instance of the running server, which is populated by the `app-server-start` function.  The `app-server-stop` function send a `:timeout 100` value to the running app server instance to gracefully shut down the server.

During REPL driven development, call `app-server-restart` to stop and start the server.

## Code example

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]))


;; Routing

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System

(defonce app-server-instance (atom nil))


(defn app-server-stop
  "Gracefully shutdown the server, waiting 100ms"
  []
  (when-not (nil? @app-server-instance)
    (@app-server-instance :timeout 100)
    (reset! app-server-instance nil)
    (println "INFO: Application server shutting down...")))


(defn app-server-start
  "Start the application server and run the application"
  [port]
  (println "INFO: Starting server on port: " port)

  (reset! app-server-instance
          (app-server/run-server #'app {:port (Integer/parseInt port)})))


(defn app-server-restart
  "Convenience function to stop and start the application server"
  []
  (app-server-stop)
  (-main))

(defn -main
  "Start the application server on a speicific port"
  [& [port]]
  (let [port (Integer. (or port (System/getenv "PORT") 8888))]
    (app-server-start port)))


;; REPL driven development

(comment

  ;; Re/Start application server
  (app-server-restart)

  ;; Shutdown server
  (app-server-stop)

)

```

[Http-kit server documentation](http://http-kit.github.io/server.html) contains details of asynchronous websockets and HTTP streaming configurations.

{% endtabs %}
