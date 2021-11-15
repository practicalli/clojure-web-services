# Reitit: Constructing routes

Create a simple Clojure project

```bash
clojure -X:project/new :template app :name practicalli/reitit-routing
```


Require reitit

```clojure
(require '[reitit.core :as reitit])
```

Define several simple routes using reitit router

Routes are defined as a collection (vector) of vectors, with each vector defining the path of the route and an optional name.

`reitit.core/router` creates a router from the collection of vectors and an optional hash-map of routes configuration options (e.g middleware)

```clojure
(def router
    (reitit/router
     [["/api/ping" ::ping]
      ["/api/game-scoreboard/:score-id" ::game-score]]))
```

> names are used to provide a unique way of referring to a route throughout the whole project, as they are a namespace qualified keyword


Selects implementation based on route details. The following options are available:

| key          | description
| -------------|-------------
| :path      | Base-path for routes
| :routes    | Initial resolved routes (default [])
| :data      | Initial route data (default {})
| :spec      | clojure.spec definition for a route data, see reitit.spec on how to use this
| :syntax    | Path-parameter syntax as keyword or set of keywords (default #{:bracket :colon})
| :expand    | Function of arg opts => data to expand route arg to route data (default reitit.core/expand)
| :coerce    | Function of route opts => route to coerce resolved route, can throw or return nil
| :compile   | Function of route opts => result to compile a route handler
| :validate  | Function of routes opts => () to validate route (data) via side-effects
| :conflicts | Function of {route #{route}} => () to handle conflicting routes
| :exception | Function of Exception => Exception  to handle creation time exceptions (default reitit.exception/exception)
| :router    | Function of routes opts => router to override the actual router implementation




Routes can be found by either path or name

```clojure

```
