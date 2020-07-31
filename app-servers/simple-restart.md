# Simple restart approach
Use a `def` expression to create a named reference to the running server, providing a simple way to stop the application server.

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

  (defn app-server-start
    [port]
    (jetty/run-jetty (site #'app) {:port port :join? false}))

  (defn -main [& [port]]
    (let [port (Integer. (or port
                             (System/getenv "PORT")
                             8080))]
      (app-server-start port)))


;; REPL driven development
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(comment

  (def app-server (-main 8080))
  (.stop app-server)
)
```


{% content "httpkit" %}
The `-main` function identifies a value for a port and calls `app-server-start` function which starts the http-kit server.  During development, a `def` is used to create a reference to a running server, this reference is used to stop the app-server by calling it with the arguments `:timeout 100` and gracefully shutting down the server.


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

(defn app-server-start
  "Start the application server and run the application"
  [port]
  (println "INFO: Starting server on port: " port)
  (app-server/run-server #'app {:port port}))

(defn -main
  "Start the application server on a speicific port"
  [& [port]]
  (let [port (Integer. (or port (System/getenv "PORT") 8888))]
    (app-server-start port)))


;; REPL driven develpment
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(comment

  (def app-server (-main))
  (app-server :timeout 100)
)
```

[Http-kit server documentation](http://http-kit.github.io/server.html) contains details of asynchronous websockets and HTTP streaming configurations.

{% endtabs %}
