# Web Apps in Clojure Overview 

  A typical Web application receives data, does something with it and returns a result.  This is the essence of how a function works in Clojure.  So again, it's really simple to build web apps with.

  As Clojure is centered around dynamically typed & immutable data structures, it makes web applications really easy to build and simple to scale through parallelism.  As most of your application will be stateless, it is less complex and less prone to conflicts.
  

## Libraries over frameworks

  Clojure also takes a very modular approach to building any application and has many great libraries to minimise the work involved.  As Java Interoperability is also very easy in Clojure, it's trivial to use Java libraries too.

  Web apps in Clojure are typically built from a collection of highly focused libraries, that complement each other's functions.  Talking a modular approach, you can swap components & libraries easily should there be value in a different approach.  Common libraries for web app development include:

* [Ring](https://github.com/ring-clojure/ring) - a web application library
* [Compojure](https://github.com/weavejester/compojure) - an simple way to define routes for your ring webapp
* [Hiccup](https://github.com/weavejester/hiccup) or [Selmer](https://github.com/yogthos/Selmer) - write html in Clojure
* [Korma](http://sqlkorma.com/), [YesQL](https://github.com/krisajenkins/yesql), [hugSql](http://www.hugsql.org) - database abstraction layers
* [clojure.java.jdbc](https://github.com/clojure/java.jdbc) or [clojure.jdbc](https://github.com/clojure/java.jdbc) - low level SQL libraries
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

* [compojure](https://github.com/weavejester/compojure-template) - a simple project with routing
* [luminus](http://www.luminusweb.net/) - a production ready app template
* [duct](https://github.com/weavejester/duct) - simple, minimal production-grade framework
* [pedestal-service](https://github.com/pedestal/pedestal) - an opinionated, extensible & scalable framework


You can find a range of project templates by [searching for lein-template on Clojars.org](https://clojars.org/search?q=lein-template).  There is also a [guide to writing templates on Leiningen.org](https://github.com/technomancy/leiningen/blob/master/doc/TEMPLATES.md)
