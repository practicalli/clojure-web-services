# REPL Driven Development for Clojure Web Apps and Services

[Practicalli Clojure provides an overview of REPL driven development](https://practical.li/clojure/repl-driven-devlopment.html)

With Clojure Web applications and services there are also long running processes to manage, dependencies between services in the system and it may be valuable to retain state of your application when loading changes.

Integrant REPL extends the REPL driven development workflow to Clojure web applications and services, following the ideas discussed in the [Clojure Reloaded workflow](https://cognitect.com/blog/2013/06/04/clojure-workflow-reloaded).

Integrant REPL is a library to manage services using a data structure that defines the configuration of each service and dependencies between services in the system or external to the system.

By defining relationships between services, such as an HTTP server and a Persistent store, a simple Inversion of control or Dependency injection approach can be achieved by passing the relevant parts of the configuration to each service.  As this is information is managed at the top level of a Clojure system, it avoids unnecessary coupling between system services.


## Reloaded REPL workflow
Reloaded REPL workflow provides a simple way to reload changes into the system as it is being developed.

A Reloaded REPL workflow manages the start and stop of these services, as well as the system configuration.  It is also possible to view the live system configuration and interact with the configuration.

![Reloaded REPL with Integrant REPL](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-webapps/clojure-repl-driven-development-reloaded-repl-concept.png)

## Integrant and Integrant REPL

Integrant is used for managing the life-cycle of services when running the application, either locally or deployed in an environment (e.g. test, stage, live).

Integrant REPL is used to manage services actively being developed and provides access to the configuration to start services (`integrant.repl.state/config`) and the configuration of the running system state (`integrant.repl.state/system`)

> TODO: add link to page in book that covers integrant


## Aero - defining environment profiles

[Aero](https://github.com/juxt/aero) provides a way to define multiple environment profiles, so the same `resources/config.edn` file can support `develop`, `test`, `stage` and `live` environments.

A specific profile value is given to `aero/read-config` which parses the Integrant configuration, returning an updated Integrant configuration containing that profiles specific values for each key.

As each part of the system can be defined using profiles, the same `resources/config.edn` configuration can be used for both Integrant and Integrant REPL


## Introduction to Integrant

An introduction to Integrant by the author of the library, James Reeves. A brief discussion of Integrant REPL is at 18:45. The video also introduces Duct, the authors web framework built on the similar principles of Integrant.

{% youtube %}
https://youtu.be/Y8mI2OZR3Fg?t=1124
{% endyoutube %}


## Alternative tools

* Mount
* Component
* Component.repl
* [JUXT/clip](https://github.com/juxt/clip)
