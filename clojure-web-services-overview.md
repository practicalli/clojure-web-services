# Overview of Clojure Web Services

<!-- TODO: Clojure Web Services overview - Review and update -->

A Web service receives data, does something with that data and returns data as a result.  This is the essence of how a function works in Clojure.  So its really simple to design web apps with Clojure.

Clojure data is managed via immutable data structures. The majority of the Clojure code will be stateless or managing state with immutable data structures, therefore code for services will be less complex and less prone to conflicts.

Relevant changes to data is persisted to a data store, e.g. PostgreSQL, Datomic or XTDB

So reliable services are very easy to build and simple to scale via parallelism.


## Libraries over frameworks

Clojure takes a modular approach to building services, assembling commonly used libraries from the community.

Java Interoperability is simple in Clojure, so its trivial to use Java libraries or any libraries that run on the JVM (Scala, Jython, etc.).

Web services in Clojure are typically built from a collection of highly focused libraries.  Each library has a specific focus and enables a modular approach, as you can swap components & libraries easily should there be value in a different approach.

Common libraries for web app development include:

* [Ring](https://github.com/ring-clojure/ring) - a web application library
* [Compojure](https://github.com/weavejester/compojure) - an simple way to define routes for your ring webapp
* [Hiccup](https://github.com/weavejester/hiccup) or [Selmer](https://github.com/yogthos/Selmer)- to generate HTML from Clojure data structures
* [Pedestal](https://github.com/pedestal/pedestal)
* [jdbc.next](https://github.com/seancorfield/next-jdbc) - a modern low-level Clojure wrapper for JDBC access to databases
* [clojure.java.jdbc](https://github.com/clojure/java.jdbc) - simple low level SQL library
* [Korma](http://sqlkorma.com/), [YesQL](https://github.com/krisajenkins/yesql), [hugSql](http://www.hugsql.org) - database abstraction layers
* [Prismatic Schema](https://github.com/Prismatic/schema) - database schema mapping
* [Migratus](https://github.com/yogthos/migratus) - database migrations (and all the things)

Large frameworks constrain the design of a service, forcing development to live inside the constraints of that framework as it can be difficult to break out of the design the framework imposes.

## Project templates

Projects can be created from templates to avoid starting from scratch each time.

Project templates

Using Leiningen
```bash
lein new template-name project-name
```
Using Clojure CLI

```bash
clojure -T:project/new :template figwheel :name practicalli/landing-page
```

There are many great templates to try that provide insight into building webapps in Clojure.

* [compojure](https://github.com/weavejester/compojure-template) - a common web application approach with ring and compojure
* [compojure-api](https://github.com/metosin/compojure-api) - quickly build API's with ring, compojure and openapi (swagger) for self-documentation
* [luminus](http://www.luminusweb.net/) - a flexible template to create server-side and full stack web applications
* [pedestal-service](https://github.com/pedestal/pedestal) - an opinionated, extensible & scalable framework
* [duct](https://github.com/weavejester/duct) - data-oriented production-grade server-side web applications
* [JUXT Edge](https://github.com/juxt/edge) - a curated base project to build your own applications and services

You can find a range of project templates by [searching for lein-template on Clojars.org](https://clojars.org/search?q=lein-template).  There is also a [guide to writing templates on Leiningen.org](https://github.com/technomancy/leiningen/blob/master/doc/TEMPLATES.md)
