# Route Requests

Https servers accept many different types of requests, defined as a combination of

* Https protocol - GET, POST, etc.
* Path of resource - page, api endpoint, etc.


## Defining routes

[Reitit]() is a data driven approach to defining routes and support ring Ring request, response and middleware.

[Compojure]() provides the defroutes macro and a simple DSL for defining routes.

{% tabs reitit="Reitit", compojure="Compojure" %}

{% content "reitit" %}

## Defining routes with Reitit

Add reitit as a dependency



Restart the REPL (unless Reitit was added using [hotload](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html))

Add reitit namespace to web-server namespace

```clojure

(ns practicalli.web-server
  (:gen-class)
  (:require [ring.adapter.jetty :as http-server]
            [reitit.core :as routing]))
```


Define example routes

```clojure
(def routes
 [["/"
    {:handler (constantly {:status 200
                           :headers {:content-type "text/html"}
                           :body "<h1>Welcome to Practicalli Clojure Web Server"})}
 ["status"
   {:handler (constantly {:status 200
                          :headers {:content-type "application/json"}
                          :body {:alive true}})}]]])
```

{% content "compojure" %}


Add Compojure as a dependency

```clojure
(ns practicalli.web-server
  (:gen-class)
  (:require [ring.adapter.jetty :as http-server]

            [compojure.core  :refer [defroutes GET]]
            [compojure.route :refer [not-found]

            [ring.middleware.reload :refer [wrap-reload]]]))
```

Restart the REPL (unless Compojure was added using [hotload](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html))

Add Compojure namespace to web-server namespace

Define example routes using the reitit ring-handler

```clojure
(defroutes app
  "Initial routes for web server"
  []

  (reitit-ring/ring-handler
   (reitit-ring/router       ;; routes defined as a vector of vectors
    [
     ["/"

     ]
]
    ;; Middleware, coersion & content negotiation

   ;; Default hanlder passed to ring-handler
   (ring/routes
    ;; Respond to any other route - returns blank page
    ;; TODO: create custom handler for routes not recognised
    (ring/create-default-handler))
)))

```

{% endtabs %}
