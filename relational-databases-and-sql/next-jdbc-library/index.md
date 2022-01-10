# SQL queries in Clojure with next.jdbc library

Using next.jdbc to connect to a database and run queries only a few steps

* add `seancorfield/next.jdbc` as a project dependcy
* require the `seancorfield/next.jdbc` in the relevant project namespace definitions
* define a database specification (hash-map of database details or JDBC string)
* create a connection  (optionally using a connection pool)
* execute SQL statements (individual, batch, transaction)

![Clojure connect to database](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-webapps-database-connection-and-sql-queries.png)


> #### Hint::next.jdbc supersedes clojure.java.jdbc
> [seancorfield/next.jdbc](https://github.com/seancorfield/next-jdbc) supersedes `clojure.java.jdbc` which used to be the defacto library for database backed projects.  next.jdbc is faster and exposes a more modern API design (according to the author of clojure.java.jdbc).
> [Migration from clojure.java.jdbc is documented](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/migration-from-clojure-java-jdbc) on the next.jdbc repository


## Live Coding example

<div style="position: relative;padding-bottom: 56.25%;padding-top: 25px;height: 0;">
  <iframe frameborder="0" allowfullscreen style="border: none;position: absolute;top: 0;left: 0;width: 100%;height: 100%;" src="//www.youtube.com/embed/5xsyuT2UjNA?start=454"></iframe></div>

<p></p>

## Summary of using next.jdbc

Include next.jdbc as a dependency in the project

```clojure
{:deps
 {org.clojure/clojure        {:mvn/version "1.10.1"}
  org.seancorfield/next.jdbc {:mvn/version "1.1.569"}}}
```

Require next.jdbc into the project namespace

```clojure
(ns practicalli.database-access
  (:require [next.jdbc :as jdbc]))
```


### Specify the database connection

Define a data source connection using a next.jdbc hash map or a JDBC URL

An example next.jdbc specification for H2 database

```clojure
{:dbtype "h2" :dbname "banking-on-clojure"}
```

An example JDBC connection string for postgres database

```clojure
"jdbc:postgresql://<hostname>:port/<database-name>?user=<username>&password=<password>&sslmode=require"
```


### Running SQL queries

`execute!` runs an SQL statement and returns the results as a vector of hash maps. The hash maps use table and column name to create qualified keywords in the results.

A Clojure string contains the SQL statement.

```clojure
(jdbc/execute!
      connection
      [(str "insert into account_holders(
               account_holder_id,first_name,last_name,email_address,residential_address,social_security_number)
             values(
               '" account-holder-id "', 'Jenny', 'Jetpack', 'jen@jetpack.org', '42 Meaning Lane, Altar IV', 'AB101112C' )")])
```


> ####Hint::Datafy results
> Hash maps returned by `execute!` use Datafy and are therefore navigable using [Clojure data browsers](http://practical.li/clojure/clojure-tools/data-browsers/)


## Using connections and queries effectively

Define a name for the database connection using the form `(jdbc/get-datasource {:dbtype "..." :dbname "..." ...})`

```clojure
(def db-spec (jdbc/get-datasource {:dbtype "h2" :dbname "banking-on-clojure"}))
```

Use the [`with-open`](https://clojuredocs.org/clojure.core/with-open) Clojure core function to automatically close connections after running SQL expressions

```clojure
    (with-open [connection (jdbc/get-connection db-spec)]
      (jdbc/execute! connection [...]))
```

Defining a generic function provides a simple way to run any SQL query for a specified data base connection.

```clojure
(defn query-database
  [db-spec sql-statement]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc/execute! connection sql-statement)))
```


## Using next.jdbc friendly functions

next.jdbc provides higher level abstractions over execute! function.  These friendly functions take a database connection, a table name as a Clojure keyword and a hash map that contains the values in the query.  As the query is a hash map it can also be represented by a Clojure specification (clojure.spec or Malli).

Function names ending with a bang, `!`, change the contents of the database

* `insert!` - insert new rows
* `query` - read data
* `update!` - update existing rows
* `delete!` - remove rows


### Generic insert function with next.jdbc.sql

To save repetition, define a generic function that uses `insert` and takes a database table name, data to insert and the database connection.

```clojure
(defn insert-data
  [db-spec table record-data]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert! connection table record-data)))
```

Call the generic insert function with the database connection, table name and query specification

```clojure
(insert-data
  db-spec
  :public.account_holders
  {:account_holder_id      (java.util.UUID/randomUUID)
   :first_name             "Rachel"
   :last_name              "Rocketpack"
   :email_address          "rach@rocketpack.org"
   :residential_address    "1 Ultimate Question Lane, Altar IV"
   :social_security_number "BB104312D"} )
```


<!-- ### Transactions for multiple queries ### -->

<!-- TODO: add example of using transactions for multiple queries -->


> ####HINT::next.jdbc getting started guide
> [next.jdbc getting started guide](https://cljdoc.org/d/seancorfield/next.jdbc/1.1.569/doc/getting-started) is very detailed.
