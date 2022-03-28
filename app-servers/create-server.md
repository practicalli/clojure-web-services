# Create a server

To create  a web (http) server using a common library, e.g. Jetty or Http-kit

1. Require a library that provides the web server
2. Create a function to start a server, taking a port number as an option


## Require Web Server Library

{% tabs jetty="Jetty", httpkit="Http-kit Server", httpkit="Http-kit Server" %}

{% content "jetty" %}

Add the web server library to the namespace using a `:reqiure` directive.

```clojure
(ns practicalli.web-server
  (:gen-class)
  (:require [ring.adapter.jetty :as http-server]))
```


## Code a basic web server

Define a function called `server-start` that takes a value for the port number which the server will listen too.

Call the `run-jetty` function from `ring.adapter.jetty` to start the Jetty Server.  `run-jetty` takes several arguments

* the main request handler, initially just a function (usually a router function to handle many different types of requests)
* a hash-map of options, e.g. `{:port 8080 :join? false}`.  [Options are listed in the `run-jetty` function definition](jetty-server-options.md).

The `:port` key is associated with an integer value that represents the port number.

The `:join` key is associated with a boolean value, `true` if the the REPL process should attached to the Jetty thread (blocking input until server stops), `false` to continue in a separate thread.

```clojure
  (defn server-start
    [port]
    (http-server/run-jetty #'app {:port port :join? false}))
```


{% content "httpkit" %}

Add the web server library to the namespace using a `:reqiure` directive.

```clojure
(ns practicalli.web-server
  (:gen-class)
  (:require [org.httpkit.server :as http-server]))
```


## Code a basic web server

Define a function called `server-start` that takes a value for the port number which the server will listen too.

Call the `run-server` function from `org.httpkit.server` to start the Http-kit server.  `run-jetty` takes several arguments

* the main request handler, initially just a function (usually a router function to handle many different types of requests)
* a hash-map of options, e.g. `{:port 8080 :join? false}`.  [Options are listed in the `run-server` function definition](jetty-server-options.md).

The `:port` key is associated with an integer value that represents the port number.

```clojure
(defn server-start
  "Start the application server and run the application"
  [port]
  (app-server/run-server #'app {:port port}))
```

[Http-kit server documentation](http://http-kit.github.io/server.html) contains details of asynchronous websockets and HTTP streaming configurations.

{% endtabs %}


## Request handler function

The server passes all HTTP requests, converted to a request hash-map by ring, to the `app` function.  The `app` function returns a ring response hash-map which is sent back to the client (browser) as an Http response.

Define a function that takes a request hash-map as an argument and returns a basic response hash-map.

```clojure
(defn app [request]
  {:status  200
   :headers {:content-type "text/html"}
   :body    "<h1>Clojure Web Server Alive</h1>"})
```


`:status` [http status code](https://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html "W3.org Hypertext Transfer Protocol status code definitions") as an integer - 200 means okay

`:header` response headers such as content type, a hash-map with optional values (the value can be an empty hash-map `{}`)

`:body` a string containing the body of the response, such as text, HTML or JSON.
