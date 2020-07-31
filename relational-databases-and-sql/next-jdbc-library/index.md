# next.jdbc library for SQL base queries
[seancorfield/next.jdbc](https://github.com/seancorfield/next-jdbc) is the defacto wrapper for JDB databases from Clojure. [next.jdbc getting started guide](https://cljdoc.org/d/seancorfield/next.jdbc/1.1.569/doc/getting-started) is very detailed.

H2 is an in-memory database which saves data to disk (`.mv.db` files).  H2 is easy to use relational database that runs does not require any authentication or authorization to use.

> #### Hint::next.jdbc supersedes clojure.java.jdbc
>  seancorfield/next.jdbc supersedes `clojure.java.jdbc` which used to be the defacto library for database backed projects.  next.jdbc is faster and exposes a more modern API design (according to the author of clojure.java.jdbc).  [Migration from clojure.java.jdbc is documented](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/migration-from-clojure-java-jdbc) on the next.jdbc repository


### Adding next.jdbc to a project
Create a new Clojure project using clj-new tool (see [Clojure install for details](http://practicalli.github.io/clojure/clojure-tools/install/install-clojure.html))

```shell
clojure -A:new app practicalli/simple-database
```

Add next.jdbc and h2 database libraries as dependencies

```clojure
{:deps {org.clojure/clojure {:mvn/version "1.10.1"}
        seancorfield/next.jdbc {:mvn/version "1.1.569"}
        com.h2database/h2 {:mvn/version "1.4.200"}}}
```

> Check clojars.org for [latest version seancorfield/next.jdbc ](https://clojars.org/seancorfield/next.jdbc) and Maven Central for [latest version of H2 database](https://mvnrepository.com/artifact/com.h2database/h2)


{% tabs repl="In the REPL", project="In a Clojure Project" %}

{% content "repl" %}
## Using next.jdbc in a REPL session
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
Edit the file `src/practicalli/simple-database.clj`

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
