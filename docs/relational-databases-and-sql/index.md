# SQL and Relational Databases

[seancorfield/next.jdbc](https://github.com/seancorfield/next-jdbc) is the defacto Clojure wrapper for SQL queries and managing connections to relational databases.

next.jdbc supports a wide range of databases and automatically pulls in the relevant database drivers.  Abstractions are provided for insert, query, update and delete actions, which define data in a hash map allow the use of [Clojure specifications](http://practicalli.github.io/clojure/clojure-spec/) (clojure.spec or Malli) for validation and generative testing.


## Relational Databases
This guide will use the following relational databases

* [H2 database](h2-database.md) - lightweight in-process database that writes to disk, easily added for a fast and simple dev environment.
* [Postgresql](postgres-database.md) - open source, feature rich and production grade database (defacto production choice)

Other persistent storage approach include

* [Amazon RDS](https://aws.amazon.com/rds/) - a postgres-like storage as an AWS service (should work just like postgres)
* [CockroachDB](https://www.cockroachlabs.com/) an elastic, indestructible SQL database for developers building modern applications
* [yugabyteDB](https://www.yugabyte.com/) open source, cloud native relational DB for powering global, internet-scale apps.

## Key Value stores

* [Redis](https://redislabs.com/)
* [RocksDB](https://rocksdb.org/) is a high performance embedded persistent key-value store with fast storage writes (fork of Google's LevelDB)
* AWS Dynamo - 400k limit per stored value

## Clojure databases
* [Crux](https://opencrux.com/) - open database with temporal graph query
* [Datomic](https://www.datomic.com/) - transactional database with a flexible data model, elastic scaling, and rich queries
Interesting databases in the Clojure spaces include Datomic and Crux.

## Database drivers
Database drivers for commonly used database

* [Apache Derby](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.apache.derby%22%20AND%20a%3A%22derby%22)
* [H2](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22com.h2database%22%20AND%20a%3A%22h2%22)
* [HSQLDB](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22hsqldb%22%20AND%20a%3A%22hsqldb%22)
* [Microsoft SQL Server jTDS](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22net.sourceforge.jtds%22%20AND%20a%3A%22jtds%22)
* [Microsoft SQL Server -- Official MS Version](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22com.microsoft.sqlserver%22%20AND%20a%3A%22mssql-jdbc%22)
* [MySQL](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22mysql%22%20AND%20a%3A%22mysql-connector-java%22)
* [PostgreSQL](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.postgresql%22%20AND%20a%3A%22postgresql%22)
* [SQLite](http://search.maven.org/#search%7Cgav%7C1%7Cg%3A%22org.xerial%22%20AND%20a%3A%22sqlite-jdbc%22)

Database drivers may require a minimum version of Java, so consider Java 8 as the minimum version and Java 11 as the recommended version (until a new long term support version of Java is release).


> see database support at http://clojure-doc.org/articles/ecosystem/java_jdbc/home.html  (is this up to date?)


<!-- ## Reuse connections and connection pooling -->
<!-- SQL queries should reuse connections rather that starting a new connection each time, as this is an expensive operation. -->

<!-- http://clojure-doc.org/articles/ecosystem/java_jdbc/reusing_connections.html -->


<!-- Connection pooling use case: -->
<!-- Financial services corporation using HikariCP connection pool with Oracle DB, establishing a 32 channel connection pool to pull in data via clojure from a Tibco Enterprise message bus. -->




<!-- ## Writing SQL -->

<!-- * [Manipulating data with SQL - clojure-doc.org java.jdbc](http://clojure-doc.org/articles/ecosystem/java_jdbc/using_sql.html) -->
<!-- * [Using DDL and Metadata for common operations](http://clojure-doc.org/articles/ecosystem/java_jdbc/using_ddl.html) - eg. dropping tables -->

<!-- ## datafy / nav -->
<!-- ? what are these and how do they relate -->



> [Feedback welcome](https://github.com/practicalli/clojure-webapps-content/issues)
