# Add Dependency

Our application will use JDBC (Java database connectivity) to connect to the Postgres database. So we need to add the JDBC library along with a a specific JDBC driver for Postgres.

> ####Note:: Add Dependencies to the project for the Heroku Postgres database

Edit the project configuration file, `project.clj` and add the following dependencies

```clojure
[org.clojure/java.jdbc "0.7.10"]
[org.postgresql/postgresql "42.2.9"]
```

The `project.clj` file should now look as follows:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}

  :dependencies [[org.clojure/clojure "1.10.1"]
                 [ring "1.8.0"]
                 [compojure "1.6.1"]
                 [org.clojure/java.jdbc "0.7.10"]
                 [org.postgresql/postgresql "42.2.9"]]
  :min-lein-version "2.0.0"
  :repl-options {:init-ns todo-list.core}
  :main todo-list.core
  :profiles {:dev
             {:main todo-list.core/-dev-main}
             :uberjar {:aot :all}}
  :uberjar-name "todo-list.jar"
  :auto-clean false)
```
