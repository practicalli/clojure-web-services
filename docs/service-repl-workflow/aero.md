# Aero System configuration

Aero library is an EDN reader that provides reader tags (tag literals) to support the declarative definition of system components, especially across different deployment environments (e.g. dev, stage, production).

A specific profile value (e.g. `:dev` `:stage` `:prod`) is given to `aero/read-config` which parses the Integrant configuration, returning an updated Integrant configuration containing values specific to the given profile.

!!! QUOTE
    Configuration should be explicit  obvious, but not clever. It should be easy to understand what the config is, and where it is declared. - JUXT.


## Aero reader

Require the `aero.core` library and use the `read-config` function to process an EDN configuration file.

```clojure
(require '[aero.core :as aero])
(aero/read-config "config.edn")
```


## Aero Tag Literals

Aero uses [tag literals](https://github.com/juxt/aero#tag-literals) as placeholders for specific values

* `#profile` - replace with the value from the given profile name
* `#env` - replace with the value of the matching operating system environment variable
* `#hostname` - replace with the value from the given computer hostname
* `#or`  - a vector of possible values, returning the first "truthy" value
* `#long` - cast a String value to a Clojure Long type (e.g. for PORT values)
* `#ref` - refer to another part of the system configuration rather than duplicate it
* `#ig/ref` - integrant version of #ref to reference another part of the system

??? INFO "Aero tag literal definitions"
    [aero/core.cljc](https://github.com/juxt/aero/blob/master/src/aero/core.cljc) contains the definitions for the Aero tag literals

??? HINT "Define Custom Tags"
    Custom tag literals can be added to extend Aero, e.g. [adding Integrant Reference tag literal](integrant-repl#aero-and-integrant)


## Profiles

Aero #profile tag literal supports multiple environment within one EDN configuration

Pass a profile and configuration to the aero reader and only the matching profile values in the configuration are returned each key.  So a profile is a type of filter on the system configuration.

```clojure title="Aero reader with profile"
(defn aero-config
  "Apply profile to service configuration: :dev :stage :prod"
  [profile]
  (aero/read-config (io/resource "config.edn") {:profile profile}))
```

As each part of the system can be defined using profiles, the same `resources/config.edn` configuration can be used for both Integrant and Integrant REPL

??? EXAMPLE "Mulog Event Publish Configuration with aero"
    The areo profiles (`:dev` `:docker` `:prod`) determine which type of publisher is use for mulog events
    ```clojure
     ;; Event logging service - mulog
     :practicalli.gameboard.service/log-publish
     {
      :mulog #profile {:dev  {:type :console-json :pretty? true}

                       ;; Multiple publishers using Open Zipkin service (started via docker-compose)
                       :docker  {:type :multi
                                 :publishers
                                 [{:type :console-json :pretty? false}
                                  {:type :zipkin :url "http://localhost:9411/"}]}

                       :prod {:type :console-json :pretty? false}}}
    ```

> As an alternative, a separate `dev/resources/config.edn` file could be defined if the development environment significantly deviates from stage and production.  Using separate files does require additional maintenance to ensure the deployed environments are consistent.


## Set default values

`#or` defines a vector of possible values, returning the first "truthy" value.

Use `#or` to define a default value to avoid `nil` appearing in the configuration, especially where `#env` is used to get operating system environment variables.

!!! EXAMPLE ""
    ```clojure
    {:practicalli.gameboard.service/http-server
     {:port #long #or [#env APP_SERVER_PORT 8888]}}
    ```


## Environment variables

`#env` tag will use Environment Variables from the Operating system as values in the configuration

Environment Variables must be defined in the Operating System before the Clojure REPL process is started.  Adding Environment Variables after the REPL starup requires a restart of the REPL to pick up the values.

!!! EXAMPLE "HTTP Server component with Profile and Environment Variables"
```clojure
{:practicalli.gameboard.service/http-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :port #profile {:develop #long #or [#env APP_SERVER_PORT 8888]
                  :test    #long #or [#env APP_SERVER_PORT 8080]
                  :stage   #long #or [#env APP_SERVER_PORT 8080]
                  :live    #long #or [#env APP_SERVER_PORT 8000]}
  :join? false}

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/relational-store}

 :practicalli.scoreboard.service/relational-store
 {:connection #profile {:develop  {:url "http://localhost/" :port 57207 :database "scoreboard-develop"}
                        :test     {:url "http://localhost/" :port 57207 :database "scoreboard-test"}
                        :stage    {:url "http://localhost/" :port 57207 :database "scoreboard-stage"}
                        :live     {:url "http://localhost/" :port 57207 :database "scoreboard"}}}}
```


## Gameboard Configuration

An example configuration for the Practicalli Gameboard Web Service

```clojure
;; --------------------------------------------------
;; Application Component configuration - Integrant & Integrant REPL
;;
;; - Event logging (mulog)
;; - HTTP Server  (embedded jetty or http-kit)
;; - Request routing (reitit)
;; - Persistence (relational) connection
;;
;; #profile used by aero to select the configuration to use for a given profile (dev, test, prod)
;; #long defines Long Integer type (required for Java HTTP server port)
;; #env reads the environment variable of the given name
;; #or uses first non nil value in sequence
;;
;; Environment variables should be defined locally and in deployment provisioner
;; --------------------------------------------------


{;; --------------------------------------------------
 ;; Event logging service - mulog

 ;; https://github.com/BrunoBonacci/mulog#publishers
 ;; https://github.com/openzipkin/zipkin
 :practicalli.gameboard.service/log-publish
 {;; Type of publisher to use for mulog events
  ;; Publish json format logs, captured by fluentd and exposed via OpenDirectory
  :mulog #profile {:dev  {:type :console-json :pretty? true}

                   ;; Multiple publishers using Open Zipkin service (started via docker-compose)
                   :docker  {:type :multi
                             :publishers
                             [{:type :console-json :pretty? false}
                              {:type :zipkin :url "http://localhost:9411/"}]}

                   :prod {:type :console-json :pretty? false}}}

 ;; --------------------------------------------------
 ;; HTTP Server - embedded service

 :practicalli.gameboard.service/http-server
 {;; Router function passed into the HTTP server form managing requests/responses
  :handler #ig/ref :practicalli.gameboard.service/router

  ;; Port number (Java Long type) - environment variable or default number
  :port  #long #or [#env HTTP_SERVER_PORT 8080]

  ;; Join REPL to HTTP server thread
  :join? false}

 ;; --------------------------------------------------
 ;; persistence - connection to Practicall relational storage

 ;; TODO: add database connection pool ?

 :practicalli.gameboard.service/relational-store
 {:host #or [#env DATABASE_HOST "localhost"]
  :port #or [#env DATABASE_PORT 3306]
  :username #or [#env DATABASE_USERNAME "gameboard"]
  :password #or [#env DATABASE_PASSWORD "trustnoone"]}

 ;; --------------------------------------------------
 ;; Data provider services
 ;; - connection to services that provide eSports data

 :practicalli.gameboard.service/data-provider
 {;; external data providers via Risky
  :llamasoft-api-url  #or [#env LAMASOFT_API_URL "http://localhost"]
  :polybus-report-uri "/report/polybus"
  :moose-life-report-uri "/api/v1/report/moose-life"
  :minotaur-arcade-report-uri "/api/v2/minotar-arcade"
  :gridrunner-revolution-report-uri "/api/v1.1/gridrunner"
  :space-giraffe-report-uri "/api/v1/games/space-giraffe"}

;; --------------------------------------------------
 ;; routing

 ;; Configure web routing application with application environment
 ;; define top-level keys to access via the environment hash-map
 ;; - :persistence - database connection information
 ;; - :services - url, endpoint, tokens for services used by the Fraud API (e.g. risky)
 :practicalli.gameboard.service/router
 {:persistence #ig/ref :practicalli.gameboard.service/relational-store
  :data-provider #ig/ref :practicalli.gameboard.service/data-provider}}
```
