# Create a compojure-api project

> ####NOTE::Create a project with tests
```bash
lein new compojure-api my-api +clojure-test
```

## Deconstruct the project

The project this template creates is relatively simple in terms of dependencies in the `project.clj` file

```clojure
  (defproject my-api "0.1.0-SNAPSHOT"
    :description "Experimenting with the compojure-api"
    :dependencies [[org.clojure/clojure "1.8.0"]
                   [metosin/compojure-api "1.1.11"]]
    :ring {:handler my-api.handler/app}
    :uberjar-name "server.jar"
    :profiles {:dev {:dependencies [[javax.servlet/javax.servlet-api "3.1.0"]
                                   [cheshire "5.5.0"]
                                   [ring/ring-mock "0.3.0"]]
                    :plugins [[lein-ring "0.12.0"]]}})
```

Interesting things to note are its using the `lein-ring` plugin, so we should run the application with `lein ring server`.

When we want to deploy the application then we should use the `lein ring uberjar` command to create an uberjar (a java archive file that includes our Clojure application and the `clojure.core` library, so we can just run it as a java library).

## `:dev` profile
In the `:dev` profile, dependencies include [`ring/ring-mock`](https://github.com/ring-clojure/ring-mock) library to help us test our server-side web application.

There is also the [`cheshire`](https://github.com/dakrone/cheshire) library to help us work with JSON data in an efficient way.
