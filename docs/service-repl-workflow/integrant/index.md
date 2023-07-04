# Integrant Overview

[:fontawesome-solid-book-open: Integrant](integrant-system.md) manages the life-cycle of components that are composed to create the Clojure service, i.e. start, stop, restart.

Integrant uses a declarative configuration (`resources/config.edn`) to define a system configuration.

Components are managed using runtime polymorphism, i.e. `defmethod`, to define how each component is managed.

- `init-key` start a component
- `halt-key!` stop a component


[:fontawesome-solid-book-open: Integrant REPL](integrant-repl.md) manages components during development to restart the services, loading all code changes into the REPL (especially useful after ranaming functions and namespaces)

`integrant.repl.state/config` shows the configuration used to start the service.  `integrant.repl.state/system` to inspect the configuration state of the running system.


Integrant and Integrant REPL can share the same system configuration file, although are otherwise separate ways of working with a system.


## Integrant configuration

Define the configuration for each part of the system, such as http server (jetty, httpkit), router application (reitit, compojure, ring) and persistence storage (postgres, crux)

Use a shared `resources/config.edn` file with Integrant for consistency.  Or if there is significant experimentation to be done, create a `dev/resources/config.edn` file

!!! EXAMPLE "Define composite components"
    ```clojure title="resources/config.edn"
    {:practicalli.gameboard.service/http-server
     {:handler #ig/ref :practicalli.gameboard.service/router
      :port  8888
      :join? false}

     :practicalli.gameboard.service/router
     {:persistence #ig/ref :practicalli.gameboard.service/relational-store}

     :practicalli.gameboard.service/relational-store
     {:connection  {:url "http://localhost/" :port 57207 :database "gameboard"}}}
    ```

Fully qualified keywords, e.g. domain.service.name/component, are used so that keys are unique throughout the system.

The fully qualified name is the namespace that contains the `defmethod init-key` for the key.  The Integrant `load-namespaces` function will automatically load all namespaces that match key names


## Composite components

Components can be composed of configuration and references to other components, creating a composite component.

For example an HTTP component may reference a request handler component and in turn the request handler may include a database connection component.

Integrant uses the `#ig/ref` tag literal to define a references to anther component.


??? EXAMPLE "Component relationships in a Clojure web service"
    * relational-store defines a database connection
    * an request router includes a reference to the database connection, so handlers can be passed connection details
    * http-server includes a reference to the router that will assign all requests to the relevant handler functions
    ```
    {:practicalli.gameboard.service/relational-store
     {:connection {:url "http://localhost/" :port 57207 :database "scoreboard"}}

     :practicalli.gameboard.service/router
     {:persistence #ig/ref :practicalli.gameboard.service/relational-store}}

     :practicalli.gameboard.service/http-server
     {:handler #ig/ref :practicalli.gameboard.service/router
      :join? false}
    ```


## Aero and Integrant

[:fontawesome-solid-book-open: Aero](/clojure-web-services/service-repl-workflow/aero/) defines a range of tag literals that can be used in a system configuration.

Aero does not include the `#ig/ref` reference so needs to be taught how to handle this tag using a `defmethod`.

!!! EXAMPLE "Define integrant ref tag for Aero reader"
    ```clojure title="Define ig/ref tag for Aero reader"
    (defmethod aero/reader 'ig/ref
      [_ tag value]
      (ig/ref value))
    ```

Now aero can parse a system configuration EDN file that contains Integrant references


## Integrant System Configuration

The system configuration is a hash-map with each component defined as a top-level key and its associated values (a hash-map of key-value pairs). Component dependencies are defined by including a component key within the definition of another component.

Defining relationships between services, such as an HTTP server and a Persistent store, are achieved by passing the relevant parts of the configuration to each service.  As this is information is managed at the top level of a Clojure system, it avoids unnecessary coupling between system services.

The request router is dependant on a database connection and an external data provider connection to provide information to the handlers that satisfy the requests.

Define the request router as a composite component including these dependant components via an Integrant reference, `#ig/ref`

!!! EXAMPLE "Integrant dependant components"
    ```clojure title="resources/clojure.edn"
     {:practicalli.gameboard.service/router
      {:persistence #ig/ref :practicalli.gameboard.service/relational-store
       :data-provider #ig/ref :practicalli.gameboard.service/data-provider}}
    ```
