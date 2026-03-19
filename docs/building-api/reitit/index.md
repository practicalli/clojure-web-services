# Reitit routing library

Reitit routing for client and server-side routing

Supports use of ring specification for the request and response bodies as a Clojure hash-map.  Ring middleware is also supported, allowing transformation of requests and responses.

Reitit provides content negotiation and data validation (clojure.spec or malli).

Open API (Swagger) version 2 and 3 provide a common way to generate API documentation, which can also be tested via a swagger-ui web interface.


## Library Dependency

Include the bundled distribution containing all modules

=== "Clojure CLI"

    ```clojure title="deps.edn"
    metosin/reitit {:mvn/version "0.10.1"}
    ```

=== "Leiningen"

    ```clojure
    [metosin/reitit "0.10.1"]
    ```


## Require namespace

Require the reitit.ring namespace to provide routing and ring specification support.

=== "Project"

    ```clojure
    (:require
     [reitit.ring :as ring])
    ```

=== "REPL"

    ```clojure
    (require '[reitit.ring :as ring])
    ```

## Router function

Takes all requests and delegates them to handler functions

Routes are defined as a vector of vectors structure, with each nested vector containing a string key defining unique paths that match a specific request.

Each key has a configuration map to define a handler for a specific HTTP method (`:get` `:ost` etc.)

```clojure
(def router
  (ring/ring-handler
   (ring/router
    [["/" {:get welcome}]
     ["/status" {:get status}]])))
```

!!! HINT "Passing system configuration argument"
    Component systems (donut, integrant) use a system configuration (hash-map) which is passed to the router component during start up.

    Define the router as a function to recieve the system configuration as an argument and make it available in part or full to the handler functions.

    ```clojure
    (defn app
      [system-config]
      (ring/ring-handler
       (ring/router
        [["/api"
          ["/v1"
           (scoreboard/routes system-config)]]]

        ;; - middleware, coersion & content negotiation
        router-configuration)))
    ```


## Handler functions

Handler functions are Clojure functions that take a request map.


```clojure
(defn welcome [_]
  {:status 200 :body "Awesome Reitit Ring"})
```

`constantly` function is commonly used for handlers that do not use the request data initially. `constantly` returns an anonymous function that takes the ring request hash-map.

```clojure
(def status
  (constantly
    (ring.util.response/response
     {:application "practicalli awesome-api Service" :status "Alive"})))
```


!!! HINT "Use `_` as argument name when request not used"
    Handlers might not use the data in a request to return a response.  By convention the `_` underscore character is used for the argument name when the request data is not used.


!!! EXAMPLE "System Status handler"
    An example status report handler namespace
    ```clojure
    (ns practicalli.awesome-api.api.system-admin
      "Gameboard API system administration handlers"
      (:require [ring.util.response :refer [response]]))

    (def status
      "Service status report for external monitoring services, e.g. Statuscake
      Return:
      - `constantly` returns an anonymous function that returns a ring response hash-map"
      (constantly (response {:application "practicalli awesome-api Service" :status "Alive"})))
    ```


## Error Messages

When the router is created from its definition, Reitit will show errors using basic formatting to make them a little more readable.

Using `reitit.dev.pretty/exception` provides human readable and development friendly exception messages.


!!! EXAMPLE "Add the reditit.dev library"
    ```clojure title="deps.edn"
     :deps
     {
      http-kit/http-kit {:mvn/version "2.8.0"}
      metosin/reitit    {:mvn/version "0.7.0"}
      metosin/reitit-dev {:mvn/version "0.7.0"} ; human readable exceptions
     }
     ;; ---------------------------------------------------------
    ```

Update the Reitit router configuration to provide an exception that will process errors using `pretty/exception`

!!! EXAMPLE "Add and Exception catch to the router definition"
    ```clojure
    (:require
     [reitit.ring :as ring]
     [reitit.dev.pretty :as pretty])

    (def router
      (ring/ring-handler
       (ring/router
        [["/" {:get welcome}]
        ["/status" {:get status}]]
       {:exception pretty/exception})))
    ```


[Pretty Errors - Reitit Docs](https://cljdoc.org/d/metosin/reitit/0.10.1/doc/basics/error-messages#pretty-errors){target=_blank .md-button}
