# Define a Database Connection

> #### Hint::Outdated: Use next.jdbc approach
> next.jdbc provides [a simple way to connect](https://github.com/seancorfield/next-jdbc/blob/develop/doc/getting-started.md) to a range of databases
>
> Heroku provides a way to [generate the connection string](https://practicalli.github.io/clojure-webapps/projects/banking-on-clojure/production-database.html#generate-the-jdbc-connection).  The Heroku build process sets an [environment variable called JDBC_DATABASE_URL which can be used with next.jdbc](https://practicalli.github.io/clojure-webapps/projects/banking-on-clojure/production-database.html#adding-postgresql-driver-to-clojure-project).


## Outdated - under review

View the Database_URL configuration variable for the Heroku Database and define a name to represent that in Clojure

Use the Heroku Toolbelt to view the configuration variables

```bash
heroku config
```

Edit the file `src/todo_list/core.clj` file and add the following definition towards the top of the file.  Substitute your own database connection values for `:subname`, `user` and `password`.

```clojure
(def postgres {:subprotocol "postgresql"
               :subname "//node.domain.com:5432/database-name"
               :user "username"
               :password "password"
               :ssl true
               :sslmode true
               :sslfactory "org.postgresql.ssl.NonValidatingFactory"})
```

Breaking down the Heroku Postgres connection string into a map  allows us to easily add options to the connection string whilst keeping it readable.

Also, a JDBC connection string has a slightly different form to the Heroku string. Heroku Posgres creates a configuration variable in the form of `postgres://[user]:[password]@[host]:[port]/[database]` whereas the JDBC connection string is of the form `jdbc:postgres://[host]:[port]/[database]?user=[user]&password=[pass]


## JDBC connection string for Heroku Postgres

`jdbc:postgresql://[host]:[port]/[database]?user=[user]&password=[password]&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory`.


Converting the map back to a JDBC connection string

```clojure
(defn remote-heroku-db-spec [host port database username password]
  {:connection-uri (str "jdbc:postgresql://" host ":" port "/" database "?user=" username "&password=" password "&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory")})
```


## From Heroku

`JDBC_DATABASE_URL` environment variable should be used for the Heroku database connection

The `DATABASE_URL` environment variable from the Heroku Postgres add-on follows this naming convention:

```none
postgres://<username>:<password>@<host>/<dbname>
```

However the Postgres JDBC driver uses the following convention:

```none
jdbc:postgresql://<host>:<port>/<dbname>?user=<username>&password=<password>
```

Notice the additional `ql` at the end of `jdbc:postgresql`.
