# Reitit routing library

Reitit routing for client-side (ClojureScript) and server-side (Clojure) routing.

Reitit.ring library provides support for the [:fontawesome-solid-book-open: Ring specification](../../reference/ring/index.md) for the request and response data as a Clojure hash-map. Using Ring middleware allows transformation of all incoming requests and outgoing responses.

Reitit provides content negotiation and data validation (clojure.spec or malli).

Swagger-UI (OpenAPI) provides a common way to generate an interactive web UI with all the API documentation, enabling greater discoverability and testing of that API.


## Library Dependency

Include the bundled distribution containing all modules

=== "Clojure CLI"
    !!! EXAMPLE
        ```clojure title="deps.edn"
        metosin/reitit {:mvn/version "0.11.0"}
        ```

=== "Leiningen"
    !!! EXAMPLE
        ```clojure title="project.clj"
        [metosin/reitit "0.11.0"]
        ```


## Require namespace

Require the reitit.ring namespace to provide routing and ring specification support.

=== "Project"
    !!! EXAMPLE "Add require to `ns` namespace definition"
        ```clojure
        (:require
         [reitit.ring :as ring])
        ```

=== "REPL"
    !!! EXAMPLE "Add require to `ns` namespace definition"
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
    Component systems (e.g. Donut/System, Integrant) use a system configuration (hash-map) which is passed to the router component during start up.

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

A Handler function is a standard Clojure function definition that take a request hash-map.

A handler for a request that has no arguments can be defined as a `def` or use `_` as the argument name.

!!! EXAMPLE "Handler: Welcome Message"
    Return the HTTP status of the request, with a custom string as the body of the response.
    ```clojure
    (defn welcome [_]
      {:status 200 :body "Awesome Reitit Ring"})
    ```

??? HINT "Use `_` as argument name when request data not used"
    By convention the `_` underscore character is used instead of an argument name when a pieced of data is not used in the current scope.

!!! EXAMPLE "Status handler"
    A handler that responds with the current status of the service.
    ```clojure
    (def status
      (constantly
        (ring.util.response/response
         {:application "practicalli awesome-api Service" :status "Alive"})))
    ```

`constantly` returns an anonymous function which is used to define handlers that have the same behaviour regardless of the request data provided.

`ring.util.response/response` creates a default ring response. Key/value pairs arguments replace or merge into the default response hash-map.


!!! EXAMPLE "System Status handler"
    An example status report handler namespace
    ```clojure
    (ns practicalli.gameboard.api.system-admin
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
