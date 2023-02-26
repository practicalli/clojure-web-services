# Clojure Service REPL workflow

The Service REPL workflow extends the reloading concept used in [Practicalli REPL Reloaded workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/){target=_blank} to Clojure Services.

Services are composed of components such as HTTP server, database connection, log publisher, message queue, request router, etc.  These components can be updated by evaluating code changes as they are made, although some changes require the component or whole system to be restarted.

Using lifecycle tools (Integrant, Mount, etc.) restarting all the components in a system can be done via one function.

Some components are dependent on other components, so must be started and stopped in the correct order, e.g.:

- a request router component is dependent on an http server component
- a database connection is dependant on a database pool
- a request router is dependant on a database connection and external data source

!!! HINT "System Configuration as Data"
    Practicalli recommends expressing a configuration as data to provide a very clearly understandable system.

Using a data configuration, each component is a top-level key associated with hash-map containing the component configuration, optionally using an aero profile to support multiple environments in which the components run (e.g. development, testing, staging, production)


![Reloaded REPL with Integrant REPL](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-web-services/clojure-repl-driven-development-reloaded-repl-concept.png)

> Integrant REPL extends the REPL driven development workflow to Clojure web applications and services, following the ideas discussed in the [Clojure Reloaded workflow](https://cognitect.com/blog/2013/06/04/clojure-workflow-reloaded){target=_blank}.


## Integrant REPL

[Integrant REPL](integrant-repl.md) is a library to define and manage components that are composed together to create the overall service.

The service configuration is a hash-map with each component defined as a top-level key and its associated values (usually a hash-map of key-value pairs). Component dependencies are defined by including a component key within the definition of another component.

Defining relationships between services, such as an HTTP server and a Persistent store, a simple Inversion of control or Dependency injection approach can be achieved by passing the relevant parts of the configuration to each service.  As this is information is managed at the top level of a Clojure system, it avoids unnecessary coupling between system services.

??? EXAMPLE "Define composite components"
    The request router is dependant on a database connection and an external data provider connection to provide information to the handlers that satisfy the requests.

    Define the request router as a composite component including these dependant components via an Integrant reference, `#ig/ref`
    ```clojure title="resources/clojure.edn"
     {:practicalli.gameboard.service/router
      {:persistence #ig/ref :practicalli.gameboard.service/relational-store
       :data-provider #ig/ref :practicalli.gameboard.service/data-provider}}
    ```

!!! INFO "Integrant and Integrant REPL"
    [Integrant](integrant.md) is used for managing the life-cycle of services when running the application, either locally or deployed in an environment (e.g. test, stage, live).

    [Integrant REPL](integrant-repl.md) is used to manage services actively being developed and provides access to the configuration to start services (`integrant.repl.state/config`) and the configuration of the running system state (`integrant.repl.state/system`)


## Aero profiles


[Aero](aero.md) provides a parser for EDN configuration files which can inject values, enabling the use of environment variables and  to define multiple configuration profiles within the same configuration file, i.e. `resources/config.edn` file can support `develop`, `test`, `stage` and `live` environments.

A specific profile value (e.g. `:dev` `:stage` `:prod`) is given to `aero/read-config` which parses the Integrant configuration, returning an updated Integrant configuration containing values specific to the given profile.

As each part of the system can be defined using profiles, the same `resources/config.edn` configuration can be used for both Integrant and Integrant REPL


### Alternative tools

* [Mount](https://github.com/tolitius/mount) - simple shared data approach using custom defstate
* [Component](https://github.com/stuartsierra/component) - provides lifecycle protocol approach using defrecord
* [Component.repl](https://github.com/stuartsierra/component.repl) - development tools for Component
* [donut.system](https://github.com/donut-party/system) - combined configuration and code, defining component groups that hold component definitions
* [JUXT/clip](https://github.com/juxt/clip){target=_blank}


## References

[:fontawesome-brands-youtube: Enter Integrant - James Reeves](https://skillsmatter.com/skillscasts/9820-enter-integrant-a-micro-framework-for-data-driven-architecture-with-james-reeves){target=_blank .md-button}

[Practicalli REPL Reloaded Workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/){target=_blank .md-button}
