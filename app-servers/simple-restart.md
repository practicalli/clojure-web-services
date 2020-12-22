# Simple restart approach
Use a `def` expression to create a named reference to the running server, providing a simple way to stop the application server.

{% tabs jetty="Jetty", httpkit="Http-kit Server", httpkit="Http-kit Server" %}

{% content "jetty" %}
The app-server starts when the application starts, as the `app-server-start` is called from `-main` once the port value has been taken from either an argument to `-main`, an operating system `$PORT` environment variable or the default 8080.

`(def app-server-instance (-main 8080))` is placed within a `(comment )` expression.  This provides a manual way for the developer to start the application server.

The `app-server-instance` is a symbol pointing to the server instance.  This instance can be used to shut down the server.

When the developer evaluates `(.stop app-server-instance)`, the instance is used to shut down the running application server.

The REPL itself is still running, so the application can be started again quickly by evaluating `(def app-server-instance (-main 8888))`.


## Code Example

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [ring.adapter.jetty :as jetty]
            [compojure.core :refer [defroutes GET]]))


;; Routing

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System

  (defn app-server-start
    [port]
    (jetty/run-jetty (site #'app) {:port port :join? false}))


  (defn -main [& [port]]
    (let [port (Integer. (or port
                             (System/getenv "PORT")
                             8888))]
      (app-server-start port)))


;; REPL driven development

(comment

  (def app-server-instance (-main 8888))
  (.stop app-server-instance)
)
```


{% content "httpkit" %}
The `-main` function identifies a value for a port and calls `app-server-start` function which starts the http-kit server.

`(def app-server-instance (-main 8888))` is placed within a `(comment )` expression.  This provides a manual way for the developer to start the application server.

The `app-server-instance` reference can be used to stop the app-server by calling it with the arguments `:timeout 100` and gracefully shutting down the server, `(app-server-instance :timeout 100)`.

## Code Example

```clojure
(ns practicalli.example-webapp
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]))


;; Routing

(defroutes app
  (GET "/" [] {:status 200 :body "App Server Running"}))


;; System

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

(comment

  (def app-server-instance (-main 8888))
  (app-server-instance :timeout 100)
)
```

[Http-kit server documentation](http://http-kit.github.io/server.html) contains details of asynchronous websockets and HTTP streaming configurations.

{% endtabs %}
