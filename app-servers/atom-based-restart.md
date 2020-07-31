# Atom based restart
A Clojure atom is used to hold a reference to a running server instance.


{% tabs jetty="Jetty", httpkit="Http-kit Server" %}

{% content "jetty" %}
The app-server starts when the application starts, as the `app-server-start` is called from `-main` once the port value has been taken from either an argument to `-main`, an operating system `$PORT` environment variable or the default 8080.

In REPL driven development, `(def server (-main 8080))` to start the application server and create a symbol pointing to the server instance.  Shut down the server `(.stop server)` will stop the server.

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [ring.adapter.jetty :as jetty]
            [compojure.core :refer [defroutes GET]]))


;; Routing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Reference to server instance
(defonce app-server (atom nil))


(defn app-server-start
"Start Jetty Application server, adding instance to global state"
  [port]
  (reset! app-server
          (jetty/run-jetty (site #'app) {:port port :join? false})))


(defn- app-server-stop []
  (when @app-server
    (.stop @server))
  (reset! server nil))


(defn- app-server-restart
  "Stop and then start the application server, loading in the new code"
  []
  (app-server-stop)
  (app-server-start))


(defn -main
  [& [port]]
  (let [port (Integer. (or port
                           (System/getenv "PORT")
                           8080))]
    (app-server-start port)))


;; REPL driven development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(comment

 (app-server-restart)
 (app-server-stop)

)
```


{% content "httpkit" %}
An atom holds an instance of the running server, which is populated by the `app-server-start` function.  The `app-server-stop` function send a `:timeout 100` value to the running app server instance to gracefully shut down the server.

During REPL driven development, call `app-server-restart`

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]))


;; Routing
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(comment

  ;; Re/Start application server
  (app-server-restart)

  ;; Shutdown server
  (app-server-stop)

)

```

[Http-kit server documentation](http://http-kit.github.io/server.html) contains details of asynchronous websockets and HTTP streaming configurations.

{% endtabs %}
