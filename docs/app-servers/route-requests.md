# Route Requests

Https servers accept many different types of requests, defined as a combination of

* Https protocol - GET, POST, etc.
* Path of resource - page, api endpoint, etc.


## Defining routes

[Reitit](https://github.com/metosin/reitit) is a data driven approach to defining routes and support ring Ring request, response and middleware.

[Compojure](https://github.com/weavejester/compojure) provides the defroutes macro and a simple DSL for defining routes.

=== "reitit"
    Add reitit as a dependency

    ```clojure title="deps.edn"
    {:paths
     ["src" "resources"]

     :deps
     {org.clojure/clojure {:mvn/version "1.10.1"}
      http-kit/http-kit   {:mvn/version "2.3.0"}
      ring/ring-core      {:mvn/version "1.8.1"}
      metosin/reitit      {:mvn/version "0.5.18"}}}
    ```

    Restart the REPL (unless Reitit was added using [hotload](https://practical.li/clojure/clojure-cli/repl-reloaded/))

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

=== "compojure"
    Add Compojure as a dependency

    ```clojure
    {:paths
     ["src" "resources"]

     :deps
     {org.clojure/clojure {:mvn/version "1.10.1"}
      http-kit/http-kit   {:mvn/version "2.3.0"}
      ring/ring-core      {:mvn/version "1.8.1"}
      ring/ring-devel     {:mvn/version "1.8.1"}
      compojure/compojure {:mvn/version "1.6.1"}}}
    ```


    Add Compojure namespace to web-server namespace

    ```clojure
    (ns practicalli.web-server
      (:gen-class)
      (:require [ring.adapter.jetty :as http-server]
    
                [compojure.core  :refer [defroutes GET]]
                [compojure.route :refer [not-found]
    
                [ring.middleware.reload :refer [wrap-reload]]]))
    ```
    
    Restart the REPL (unless Compojure was added using [hotload](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html))
    
    Define routes using compojure
    
    ```clojure
    (defroutes app
      (GET "/"         [] handler/welcome-page)
      (GET "/accounts" [] handler/accounts-overview-page)
      (GET "/account"  [] handler/account-history)
      (GET "/transfer" [] handler/money-transfer)
      (GET "/payment"  [] handler/money-payment)
      (GET "/register" [] handler/register-customer) )
    ```

