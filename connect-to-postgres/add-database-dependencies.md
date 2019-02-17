# Add Dependency

Our application will use JDBC (Java database connectivity) to connect to the Postgres database. So we need to add the JDBC library along with a a specific JDBC driver for Postgres.

> ####Note:: Add Dependencies to the project for the Heroku Postgres database

Edit the project configuration file, `project.clj` and add the following dependencies

```clojure
[org.clojure/java.jdbc "0.3.7"]
[postgresql/postgresql "9.1-901-1.jdbc4"]
```

The `project.clj` file should now look as follows:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A simple webapp in Clojure"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [ring "1.4.0-beta2"]
                 [compojure "1.3.4"]
                 [org.clojure/java.jdbc "0.3.7"]
                 [postgresql/postgresql "9.1-901-1.jdbc4"]]
  :min-lein-version "2.0.0"
  :main todo-list.core
  :uberjar-name "todo-list.jar"
  :auto-clean false
  :profiles {:uberjar {:aot :all}})
```
