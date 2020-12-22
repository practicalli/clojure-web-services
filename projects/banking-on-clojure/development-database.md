# Provision the development database
To keep the development environment self-contained the H2 in-memory database will be used for development of the application.  Postgresql database will be used for testing and live environments hosted in the Cloud.


## Add H2 database library dependency
Edit the `deps.edn` file in the root of the project directory. In the `:deps` hash-map, add next.jdbc library as a main dependency.

As the H2 database is only used for development create a `:dev` alias include an `:extra-deps` section for the H2 driver

```clojure
{:deps
 {org.clojure/clojure    {:mvn/version "1.10.1"}
 seancorfield/next.jdbc {:mvn/version "1.1.569"}}}

{:alases
  {:dev
   {:extra-deps {com.h2database/h2 {:mvn/version "1.4.200"}}}}}
```

## Create a namespace for database access
Create a new file in the project called `src/practicalli/database-access.clj` which will contain the code for accessing the database.

Require the next.jdbc namespace using the `jdbc` alias.

```clojure
(ns practicalli.database-access
  (:require [next.jdbc :as jdbc]))
```

> next.jdbc will use the database specification to look up the driver namespace for the specific database.  Therefore the database driver namespaces do not need to be explicitly required in the namepace.


## Specifying the database and connection
H2 in-memory database is used as a self-contained database, providing a simple way to start evaluating the schema and queries as they are designed.

Use next.jdbc library to define a database specification, represented as a map.  For the H2 database only the database type and database name are required. No rolesor credentials are used to access the database as it is only running locally.

Use the database specification to create a connection

```clojure

;; Database specification and connection

;; Development environment
;; H2 in-memory database
(def db-specification-dev {:dbtype "h2" :dbname "banking-on-clojure"})

;; Database connection
(def data-source-dev (jdbc/get-datasource db-specification-dev))
```

The database specification is used to create a database connection.  A general name can be used here as only one database will be used for one environment.


> #### Hint::Aero for multiple environment configuration
> [juxt/aero](https://github.com/juxt/aero) is a library for managing configurations across multiple environments in a single EDN file.  aero can be used to hold the details of each database specification for every environment (dev, staging, live).
>
> `(read-config (clojure.java.io/resource "config.edn"))` with the configuration file in the resources directory of the classpath.  This is accessible from the Jar and the REPL.


## Using connections effectively
Use the `with-open` function to manage the database connections and ensure the connects are closed after the sql queries complete.

```clojure
(with-open [connection (jdbc/get-connection data-source-dev)]
  (jdbc/execute! connection ["SQL statement"]))
```

When multiple SQL queries should be run together, the [`with-open`](https://clojuredocs.org/clojure.core/with-open) function enables reuse of the connection and ensure the connection is cleaned up once the SQL statements are complete.

```clojure
(with-open [connection (jdbc/get-connection data-source-dev)]
  (jdbc/execute! connection ["SQL statement"])
  (reduce my-fn init-value (jdbc/plan connection ["SQL statement"]))
  (jdbc/execute! connection ["SQL statement"]))
```


> #### Hint::
> `next.jdbc` uses raw Java JDBC types so it is important to close connections to avoid issues.
