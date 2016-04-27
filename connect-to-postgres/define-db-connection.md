# Define a Database Connection

> **Note** View the Database_URL configuration variable for the Heroku Database and define a name to represent that in Clojure 

Use the Heroku Toolbelt to view the configuration variables

```bash
heroku config
```

Edit the file `src/todo_list/core.clj` file and add the following definition towards the top of the file.  Substitute your own database connection values for `:subname`, `user` and `password`.

```clojure 
(def postgres {:subprotocol "postgresql"
               :subname "//ec2-54-225-134-223.compute-1.amazonaws.com:5432/d9mtan2ol8uhik"
               :user "trhrcgefmyolkw"
               :password "hiFKxwqt9xT7MJ97hjri_c98Nm"
               :ssl true
               :sslmode true
               :sslfactory "org.postgresql.ssl.NonValidatingFactory"})
```


Breaking down the Heroku Postgres connection string into a map  allows us to easily add options to the connection string whilst keeping it readable.

Also, a JDBC connection string has a slightly different form to the Heroku string. Heroku Posgres creates a configuration variable in the form of `postgres://[user]:[password]@[host]:[port]/[database]` whereas the JDBC connection string is of the form `jdbc:postgres://[host]:[port]/[database]?user=[user]&password=[pass]


JdBC connection string for Heroku Postgres

`jdbc:postgresql://[host]:[port]/[database]?user=[user]&password=[password]&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory`.


Converting the map back to a JDBC connection string 

```
(defn remote-heroku-db-spec [host port database username password]
  {:connection-uri (str "jdbc:postgresql://" host ":" port "/" database "?user=" username "&password=" password "&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory")})
```


## From Heroku 

The DATABASE_URL for the Heroku Postgres add-on follows this naming convention:

postgres://<username>:<password>@<host>/<dbname>

However the Postgres JDBC driver uses the following convention:

jdbc:postgresql://<host>:<port>/<dbname>?user=<username>&password=<password>

Notice the additional `ql` at the end of `jdbc:postgresql`.  Due to this difference you will need to hardcode the scheme to jdbc:postgresql 



