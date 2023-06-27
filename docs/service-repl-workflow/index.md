# Clojure Service REPL workflow

Practicalli Service REPL workflow extends the reloading concept and tools used in [Practicalli REPL Reloaded workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/){target=_blank} to Clojure Services.

Services are composed of components such as HTTP server, database connection, log publisher, message queue, request router, etc.  These components can be updated by evaluating code changes as they are made, although some changes require the component or whole system to be restarted.

Lifecycle tools (Donut, Integrant, Mount, etc.) manage the components in a system, e.g. `(start)`, `(restart)`, `(stop)`.  The state of a running system can be inspected, `(system)`, as it is represented by a Clojure hash-map.

!!! HINT "System Configuration as Data"
    Practicalli recommends expressing a system configuration as data to provide a readily understandable system.


A component may have a dependancy on one or more other components, so starting and stoping the sytem should manage components in the correct order, e.g.:

- a request router component is dependent on an http server component
- a request router is dependant on a database connection to an external data source

Using a data configuration, each component is a top-level key associated with hash-map containing the component configuration, optionally using an aero profile to support multiple environments in which the components run (e.g. development, testing, staging, production)

![Service Reloaded REPL with components](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-web-services/clojure-repl-driven-development-reloaded-repl-concept.png)


## Aero Configuration

[Aero](aero.md) provides tag litterals to use with an EDN configuration file to inject values based on a `#profile` or `#env` environment variables.

Multiple configurations can be defined within the same file, i.e. `resources/config.edn`, with each profile providing values for a specific environment, e.g. `dev`, `test`, `stage` and `prod` environments.


### System component libraries

- [Mount](https://github.com/tolitius/mount) - shared data approach using custom defstate `atom`
- [donut.system](https://github.com/donut-party/system) - configuration as data, functions to manage components
- [Integrant & Integrant REPL](integrant/) - configuration as data, runtime polymorphism (defmethod) to manage components, repl reloading tools
- [Component](https://github.com/stuartsierra/component) - provides lifecycle protocol approach using defrecord
- [Component.repl](https://github.com/stuartsierra/component.repl) - development tools for Component
- [JUXT/clip](https://github.com/juxt/clip){target=_blank}


## References

[:fontawesome-brands-youtube: Enter Integrant - James Reeves](https://skillsmatter.com/skillscasts/9820-enter-integrant-a-micro-framework-for-data-driven-architecture-with-james-reeves){target=_blank .md-button}

[Practicalli REPL Reloaded Workflow](https://practical.li/clojure/clojure-cli/repl-reloaded/){target=_blank .md-button}

[Clojure Reloaded workflow](https://cognitect.com/blog/2013/06/04/clojure-workflow-reloaded){target=_blank .md-button}

