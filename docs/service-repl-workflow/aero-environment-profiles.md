# Aero System configuration

Aero enables a declarative definition of system components using Clojure hash-maps.


Expressing a configuration purely as data helps

Each component is a top-level key associated with hash-map containeing the component configuration, optionally using a profile to support multiple environments in which the components will run (e.g. development, testing, staging, production)


## Configuration as data

Configuration should be explicit  obvious, but not clever. It should be easy to understand what the config is, and where it is declared.



```
(require '[aero.core :as aero])
(aero/read-config "config.edn")
```

## Aero Tag Literals

Aero uses [tag literals](https://github.com/juxt/aero#tag-literals) as placeholders for specific values and custom tag litterals can be added



* `#profile` - replace with the value from the given profile name
* `#hostname` - replace with the value from the given computer hostname
* `#or`  - a vector of possible values, returning the first "truthy" value
* `#long` - cast a String value to a Clojure Long type (e.g. for PORT values)
* `#ref` - refer to another part of the system configuration rather than duplicate it
* `#ig/ref` - integrant version of #ref to reference another part of the system



## Component Relationships

`#ig/ref` defines a reference (relationship) to another component

In the following example,

* relational-store defines a database connection
* an request router includes a reference to the database connection, so handlers can be passed connection details
* http-server includes a reference to the router that will assign all requests to the relevant handler functions

```
{:practicalli.scoreboard.service/relational-store
 {:connection {:url "http://localhost/" :port 57207 :database "scoreboard"}}

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/relational-store}}

 :practicalli.scoreboard.service/http-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :join? false}

```


## profiles

The same configuration can be used that starts the system using profiles, or a separate develop profile can be created.

`#profile` is a tag literal used to express values for different deployment configurations.

When a specific profile is used to parse the configuration only the matching profile values are returned each key.  So a profile is a type of filter on each part of the system configuration.

As each part of the system can be defined using profiles, the same `resources/config.edn` configuration can be used for both Integrant and Integrant REPL


```clojure
{:practicalli.scoreboard.service/http-server
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


## Gameboard example

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
 ;; persistence - connection to Billie shared relational storage

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
