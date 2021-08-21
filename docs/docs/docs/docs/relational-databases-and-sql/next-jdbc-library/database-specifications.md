# Database Specifications

Call the `next.jdbc/get-datasource` function with a database specification or a JDBC URL string

 A database specification is a hash map describing the database you wish to connect to.  TODO: examples of database specifications

A "database spec" is a Clojure map that specifies how to access the data source. Specify the database type, the database name, and the username and password.

```clojure
(def db-spec
  {:dbtype "mysql"
   :dbname "mydb"
   :user "myaccount"
   :password "secret"})
```

> use aero to use a different database specification based on the environment being run (dev, test, prod, etc.)
>
> next.jdbc also works with connection pooling libraries which can be used to construct a datasource from. Examples include HikariCP or c3p0
