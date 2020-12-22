# Simple database example
Create a project called simple database

```shell
clojure -A:new app practicalli/simple-database
```

Edit the `deps.edn` file in the root of the project directory.

In the `:deps` hash-map, add next.jdbc library as dependency and add a `:dev` alias could include an `:extra-deps` section for the H2 driver

```clojure
{:deps {org.clojure/clojure    {:mvn/version "1.10.1"}
        seancorfield/next.jdbc {:mvn/version "1.1.569"}}}

{:dev
  {:extra-deps {com.h2database/h2      {:mvn/version "1.4.200"}}}}
```


{% tabs repl="In the REPL", project="In a Clojure Project" %}

{% content "repl" %}
## Using next.jdbc in a REPL session
In a terminal window, change to the root directory of the `simple-database` project.

Start a [Rebel REPL](http://practicalli.github.io/clojure/clojure-tools/rebel-repl/) from the root of the new project

```shell
cd simple-project

clojure -A:rebel
```
The first time libraries are used they are downloaded and cached locally (`~/.m2/repository`)

![clojure webapps database repl simple database rebel dependencies](/images/clojure-webapps-database-repl-simple-database-rebel-dependencies.png)

Require the `next.jdbc` namespace using an alias called `jdbc`

```clojure
(require '[next.jdbc :as jdbc])
```

Define a database specification containing the details of the H2 database to be used

```clojure
(def db-specification {:dbtype "h2" :dbname "address-book"})
```

> #### Hint::Database driver lookup
> The `:dbtype` (:classname) is used to [find the correct database driver](https://github.com/seancorfield/next-jdbc/blob/develop/src/next/jdbc/connection.clj#L52-L123)


Define a data source that is a connection to the database

```clojure
(def data-source (jdbc/get-datasource db-specification))
```

Create a table in the database using a standard SQL statement

```clojure
(jdbc/execute!
  data-source
  ["create table contacts (
     id int auto_increment primary key,
     name varchar(32),
     email varchar(255))"])
```

> A `address-book.mv.db` file is created in the root of the project

Insert an entry into the database by executing an SQL insert query

```clojure
(jdbc/execute!
  data-source
  ["insert into contacts(name,email)
    values('Jenny Jetpack','jenny@jetpack.org')"])
```

View all the records added to the database (there should be only one)

```clojure
(jdbc/execute!
  data-source
  ["select * from address"])
```

![Clojure webapps database repl simple database execute select all](/images/clojure-webapps-database-repl-simple-database-execute-select.png)


To delete all the records in the database, drop the contacts table in the database

```clojure
(jdbc/execute!
  data-source
  ["drop table contacts"])
```

![Clojure webapps database repl simple database execute drop table](/images/clojure-webapps-database-repl-simple-database-execute-drop-table.png)


{% content "project" %}
Edit the file `src/practicalli/simple-database.clj` from the `simple-database` project.

Update the `practicalli.simple-database` namespace definition with a require statement for next.jdbc

```
(ns practicalli.simple-database
  (:gen-class)
  (:require [next.jdbc :as jdbc]))
```

Define a data source for the H2 database

```clojure
(def db-specification {:dbtype "h2" :dbname "address-book"})
```

> #### Hint::Database driver lookup
> The `:dbtype` (:classname) is used to [find the correct database driver](https://github.com/seancorfield/next-jdbc/blob/develop/src/next/jdbc/connection.clj#L52-L123)


Define a data source that is a connection to the database

```clojure
(def data-source (jdbc/get-datasource db-specification))
```

Create a table in the database using a standard SQL statement

```clojure
(jdbc/execute!
  data-source
  ["create table contacts (
     id int auto_increment primary key,
     name varchar(32),
     email varchar(255))"])
```

> A `address-book.mv.db` file is created in the root of the project

Insert an entry into the database by executing an SQL insert query

```clojure
(jdbc/execute!
  data-source
  ["insert into contacts(name,email)
    values('Jenny Jetpack','jenny@jetpack.org')"])
```

View all the records added to the database (there should be only one)

```clojure
(jdbc/execute!
  data-source
  ["select * from address"])
```

To delete all the records in the database, drop the contacts table in the database

```clojure
(jdbc/execute!
  data-source
  ["drop table contacts"])
```




{% endtabs %}
