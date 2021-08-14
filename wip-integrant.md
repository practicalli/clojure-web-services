# Integrant Config

A global configuration to start, restart and halt all the services that make up the system.


```clojure
{:practicalli.scoreboard.service/app-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :port 8888
  :join? false}

 :practicalli.scoreboard.service/router
 {:persistence-connection #ig/ref :practicalli.scoreboard.service/persistence}

 :practicalli.scoreboard.service/persistence
 {:connection {:url "http://localhost/" :port 12345 :database "scoreboard"}
  }

 #_()}

```



## aero configuration for multiple environments


Aero thingies
* #profile - replace with the value from the given profile name
* #or  - a vector of possible values, returning the first "truthy" value
* #long - cast the value to a Clojure Long type

```clojure
{:practicalli.scoreboard.service/app-server
 {:handler #ig/ref :practicalli.scoreboard.service/router
  :port #profile {:develop #long #or [#env APP_SERVER_PORT 8888]
                  :stage   #long #or [#env APP_SERVER_PORT 8080]
                  :live    #long #or [#env APP_SERVER_PORT 8000]}
  :join? false}

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/relational-data-store}

 :practicalli.scoreboard.service/relational-data-store
 {:connection #profile {:develop  {:url "http://localhost/" :port 57207 :database "customer-entitlements-develop"}
                        :stage    {:url "http://localhost/" :port 57207 :database "customer-entitlements-stage"}
                        :live     {:url "http://localhost/" :port 57207 :database "customer-entitlements"}}
  ;;TODO: dynamodb: provide environment variables / access credentials for all environments
  }

 #_()}

```


configuration: environment profiles with aero

Aero library provides tag literals to configure values specific to each
environment, all from one configuration file

Tag literals include
- #profile - define a map of environment values
- #env - get values from environment variables
- #or - first truthy value from a vector of options
- #long - cast a value to a Clojure long type

Configuration file - config.edn
Renamed top-level keys to represent namespace each key is initiated in and use
autoresolve names for the ig/init-key defmethod expressions

Start / Stop service
Use aero to prepare the configuration and `start` & `stop` helper functions to
easily manage the application from the REPL

Dependencies
- remove environ
- add aero






# Integrant pitfalls


Avoid using the same name for a key inside a configuration as the name for a referred (top-level) key

In this example the `:persistence` key clashes with the `:practicalli.scoreboard.service/persistence` top-level key

```clojure

 :practicalli.scoreboard.service/router
 {:persistence #ig/ref :practicalli.scoreboard.service/key-value-store}

 :practicalli.scoreboard.service/key-value-store
 {:connection #profile {:develop  {:url "http://localhost/" :port 57207 :database "customer-entitlements-develop"}
                        :stage    {:url "http://localhost/" :port 57207 :database "customer-entitlements-stage"}
                        :live     {:url "http://localhost/" :port 57207 :database "customer-entitlements"}}

```





# Integrant REPL

Example


```clojure
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Development tools namespace
;;
;; Use the commands in the rich comment block to start, restart and halt the system
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(ns user
  (:require
   [aero.core            :as aero]
   [clojure.java.io      :as io]
   [integrant.repl       :as ig-repl]
   [integrant.repl.state :as ig-state]

   [clojure.pprint :as pprint]))


;;;; System Configuration

(defn enviroment-prep!
  "Parse system configuration with aero-reader and apply the given profile values
  Return: Integrant configuration to be used to start the system"
  [profile]
  (aero/read-config (io/resource "config.edn") {:profile profile})
  #_(ig-repl/set-prep! (statsbomb.entitlements.service/aero-prep :develop)))


;;;; REPL convenience functions

(defn go
  "Prepare configuration and start the system services with Integrant-repl"
  ([] (go :develop))
  ([profile] (enviroment-prep! profile) (ig-repl/go)))


(defn reset
  "Read updates from the configuration and restart the system services with Integrant-repl"
  [profile] (enviroment-prep! profile) (ig-repl/reset))

(defn halt
  "Shutdown all services"
  [] (ig-repl/halt))

(defn system
  "The running system configuration"
  [] (ig-state/system))

(defn config
  "The current system configuration used by Integrant"
  [] (ig-state/config))


;; Rich comment block with redefined vars ignored
#_{:clj-kondo/ignore [:redefined-var]}
(comment

  ;; Prepare and start the system using the :develop profile
  (go)

  ;; Reload source files and restart the system:
  (reset :develop)

  ;; Return the Integrant configuration
  (config)

  ;; Shutdown the system using the app-server object reference in the Integrant state
  (halt)

  ;; Show the running system configuration
  (system)

  ;; Print the system state in the REPL
  (pprint/pprint ig-state/system)

  #_()) ;; End of rich comment block

```












> TODO: investigate: setting directories - is this needed?


;; Return the integrant configuration from the configuration file
#_(ig-repl/set-prep! (fn [] (-> "resources/config.edn" slurp ig/read-string)))



;;;; System Configuration
```clojure
(defn enviroment-prep!
  "Parse system configuration with aero-reader and apply the given profile values
  Return: Integrant configuration to be used to start the system"
  [profile]
  (aero/read-config (io/resource "config.edn") {:profile profile})
  #_(ig-repl/set-prep! (statsbomb.entitlements.service/aero-prep :develop)))

```


;; define go as a REPL convenience function
;; optionally taking a keyword representing the name of environment to run under

```clojure
(defn go
  "Prepare configuration and start the system services with Integrant-repl"
  ([] (go :develop))
  ([profile] (enviroment-prep! profile) (ig-repl/go)))

```


;; Rather than using a arity based ploymorphic function
;; use the & variable arity syntax and use `or` to use the argument or :develop profile

```clojure
#_(defn go-redux
    "Prepare configuration and start the system services with Integrant-repl"
    [& profile]
    (set-prep! (or (first profile) :develop))
    (ig-repl/go))

```






  ;; Set directories monitored for changed files:
  #_(require '[clojure.tools.namespace.repl :refer [set-refresh-dirs]])
  #_(set-refresh-dirs "src")


## Minimal REPL startup time - Lambda Island
