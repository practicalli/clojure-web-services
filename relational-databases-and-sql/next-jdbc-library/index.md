# next.jdbc library for SQL with Clojure
[seancorfield/next.jdbc](https://github.com/seancorfield/next-jdbc) is the defacto wrapper for JDB databases from Clojure. [next.jdbc getting started guide](https://cljdoc.org/d/seancorfield/next.jdbc/1.1.569/doc/getting-started) is very detailed.

Using next.jdbc is simple and requires only a few steps
* require the next.jdbc library
* define a database specification (hash-map of database details)
* create a connection  (or use connection pool)
* execute SQL statements (individual, batch, transaction)

![Clojure connect to database](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-webapps-database-connection-and-sql-queries.png)


> #### Hint::next.jdbc supersedes clojure.java.jdbc
>  seancorfield/next.jdbc supersedes `clojure.java.jdbc` which used to be the defacto library for database backed projects.  next.jdbc is faster and exposes a more modern API design (according to the author of clojure.java.jdbc).  [Migration from clojure.java.jdbc is documented](https://cljdoc.org/d/seancorfield/next.jdbc/CURRENT/doc/migration-from-clojure-java-jdbc) on the next.jdbc repository


<div style="position: relative;padding-bottom: 56.25%;padding-top: 25px;height: 0;">
  <iframe frameborder="0" allowfullscreen style="border: none;position: absolute;top: 0;left: 0;width: 100%;height: 100%;" src="//www.youtube.com/embed/5xsyuT2UjNA?start=454"></iframe></div>

<p></p>

## Summary of using next.jdbc
The primary SQL execution API in next.jdbc is:

**`plan`**
yields an IReduceInit that, when reduced, executes the SQL statement and then reduces over the ResultSet with as little overhead as possible.

**`execute!`** -- executes the SQL statement and produces a vector of realized hash maps, that use qualified keywords for the column names, of the form :<table>/<column>. If you join across multiple tables, the qualified keywords will reflect the originating tables for each of the columns. If the SQL produces named values that do not come from an associated table, a simple, unqualified keyword will be used. The realized hash maps returned by execute! are Datafiable and thus Navigable (see Clojure 1.10's datafy and nav functions, and tools like Cognitect's REBL). Alternatively, you can specify {:builder-fn rs/as-arrays} and produce a vector with column names followed by vectors of row values. rs/as-maps is the default for :builder-fn but there are also rs/as-unqualified-maps and rs/as-unqualified-arrays if you want unqualified :<column> column names (and there are also lower-case variants of all of these).

*`execute-one!`* -- executes the SQL or DDL statement and produces a single realized hash map. The realized hash map returned by execute-one! is Datafiable and thus Navigable.

In addition, there are API functions to create PreparedStatements (prepare) from Connections, which can be passed to plan, execute!, or execute-one!, and to run code inside a transaction (the transact function and the with-transaction macro).

## Using connections effectively
Use the [`with-open`](https://clojuredocs.org/clojure.core/with-open) Clojure core function to reuse connections and ensure they are cleaned up correctly:
`next.jdbc` uses raw Java JDBC types

```clojure
  (let [my-datasource (jdbc/get-datasource {:dbtype "..." :dbname "..." ...})]
    (with-open [connection (jdbc/get-connection my-datasource)]
      (jdbc/execute! connection [...])
      (reduce my-fn init-value (jdbc/plan connection [...]))
      (jdbc/execute! connection [...])))
```
