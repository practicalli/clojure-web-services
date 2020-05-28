# Web Apps in Clojure Overview
  A typical Web application receives data, does something with it and returns a result.  This is the essence of how a function works in Clojure.  So its really simple to design web apps with Clojure.

  As Clojure is centered around dynamic types and immutable data structures, it makes web applications really easy to build and simple to scale through parallelism.  The majority of your application will be stateless, therefore will be less complex and less prone to conflicts.


## Libraries over frameworks
  Clojure also takes a very modular approach to building any application and has many great libraries to minimise the work involved.  As Java Interoperability is also very easy in Clojure, its trivial to use Java libraries too.

  Web apps in Clojure are typically built from a collection of highly focused libraries.  Each library has a specific focus and enables a modular approach, as you can swap components & libraries easily should there be value in a different approach.

  Common libraries for web app development include:

* [Ring](https://github.com/ring-clojure/ring) - a web application library
* [Compojure](https://github.com/weavejester/compojure) - an simple way to define routes for your ring webapp
* [Hiccup](https://github.com/weavejester/hiccup) or [Selmer](https://github.com/yogthos/Selmer)- to generate HTML from Clojure data structures
* [jdbc.next](https://github.com/seancorfield/next-jdbc) - a modern low-level Clojure wrapper for JDBC access to databases
* [clojure.java.jdbc](https://github.com/clojure/java.jdbc) - simple low level SQL library
* [Korma](http://sqlkorma.com/), [YesQL](https://github.com/krisajenkins/yesql), [hugSql](http://www.hugsql.org) - database abstraction layers
* [Prismatic Schema](https://github.com/Prismatic/schema) - database schema mapping
* [Migratus](https://github.com/yogthos/migratus) - database migrations (and all the things)

The closed thing to a framework in Clojure is [Pedestal](https://github.com/pedestal/pedestal).  Frameworks constrain you to a certain approach to building apps and if you can live inside these constraints they can be very powerful.

## Project templates
  You don't have to build projects from scratch each time, although this is a valid approach.  There are many great Clojure project templates available via the build automation tool, [Leiningen](http://leiningen.org/)

Project templates are used as follows

```
lein new template-name project-name
```

There are many great templates to try that provide insight into building webapps in Clojure.

* [compojure](https://github.com/weavejester/compojure-template) - a common web application approach with ring and compojure
* [compojure-api](https://github.com/metosin/compojure-api) - quickly build API's with ring, compojure and openapi (swagger) for self-documentation
* [luminus](http://www.luminusweb.net/) - a flexible template to create server-side and full stack web applications
* [pedestal-service](https://github.com/pedestal/pedestal) - an opinionated, extensible & scalable framework
* [duct](https://github.com/weavejester/duct) - data-oriented production-grade server-side web applications
* [JUXT Edge](https://github.com/juxt/edge) - a curated base project to build your own applications and services

You can find a range of project templates by [searching for lein-template on Clojars.org](https://clojars.org/search?q=lein-template).  There is also a [guide to writing templates on Leiningen.org](https://github.com/technomancy/leiningen/blob/master/doc/TEMPLATES.md)
