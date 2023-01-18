![Clojure specifications for next.jdbc](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/spec/clojure-spec-blueprints-industrial.png)

# Generate database record data from Clojure Specifications

The Clojure specifications developed for the banking-on-clojure application can be used to generate random data that can be used to test the database schema and CRUD functions.

In the database schema design page the `next.jdbc.sql` functions were used to define a generic function for inserting records into a database

```clojure
(defn insert-record
  [table record-data db-spec]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert! connection table record-data)))
```

The call to this function uses a value for `record-data` that is almost identical to the value generated from the `practicalli.banking-on-clojure/account-holder` specification.  The only difference is the key name styles.


```clojure
(create-record db-specification-dev
                 :public.account_holders
                 {:account_holder_id      (java.util.UUID/randomUUID)
                  :first_name             "Rachel"
                  :last_name              "Rocketpack"
                  :email_address          "rach@rocketpack.org"
                  :residential_address    "1 Ultimate Question Lane, Altar IV"
                  :social_security_number "BB104312D"})
```


## Generating data from Clojure Specifications
`clojure.spec.alpha/gen` takes a spec and returns a reference to a generator for that specification.

`clojure.spec.gen.alpha/generate` returns a random value using the spec generator.

Generate a value from the `account-holder` specification

```clojure
(spec-gen/generate (spec/gen ::account-holder))
```

Create a simple helper function in `practicalli/specifications-banking.clj` to generating mock data from the specifications relevant to the database.

```clojure
(defn mock-data-account-holder
  []
  (spec-gen/generate (spec/gen ::account-holder)))
```

The `practicalli.database-access/create-record` function can now be passed a generated record-data argument using `(practicalli.specifications-banking/mock-data-account-holder)`

```clojure
(create-record
  db-specification-dev
  :public.account_holders
  (practicalli.specifications-banking/mock-data-account-holder))
```

## Clojure and database naming disparity
When calling `create-record` with a specification there is a disparity between the names of the keys from the clojure specification and the names of the columns in database.

* Clojure uses `kebab-case`
* Database uses `snake_case`

![keyword disparity](/images/clojure-webapps-database-testing-keywords-in-kebab-case.png)

Most relational databases will not accept column names in `kebab-case`.

Do we have to compromise the Clojure style kebab-case just for the database?  Do we have to create our own generators or transform code to convert the specs generated?


## Automatically converting key names
Clojure uses [kebab-case](https://practicalli.github.io/clojure/reference/kebab-case.html) for key names in Clojure specs (and all names in general).

Relational databases use snake_case for table and column names and most databases will not support kebab-case.

It is simple to convert between the two cases, as its simply a string replacement for `-` with `_`.  [clj-commons/camel-snake-kebab](https://clj-commons.org/camel-snake-kebab/) is a library that converts between each of the naming styles.

`camel-snake-kebab.core/->snake_case` takes a name and returns it in snake_case

next.jdbc support conversion between camel-case names when [clj-commons/camel-snake-kebab](https://clj-commons.org/camel-snake-kebab/) is added to the project dependencies.

The next.jdbc.sql CRUD functions take an optional configuration hash-map as the fourth argument.  When ,,, is on the class path, next.jdbc has two hash-maps available that will define functions to use from the ,,, library to do the name conversions.

* `next.jdbc/snake-kebab-opts` for unqualified Clojure keywords
* `next.jdbc/unqualified-snake-kebab-opts` for unqualified Clojure keywords


## Refactor CRUD functions to automatically convert case
Refactor the CRUD functions to include the `snake-kebab-opts` hash-map as an argument.

Only those functions that take keywords as part of the argument need to be changed, so `next.jdbc.sql/query` does not need to change and therefore the `practicalli.database-access/read-record` remains unchanged.

Refactor the `practicalli.database-access/create-record` function

```clojure
(defn create-record
  "Insert a single record into the database using a managed connection.
  Arguments:
  - table - name of database table to be affected
  - record-data - Clojure data representing a new record
  - db-spec - database specification to establish a connection"
  [db-spec table record-data]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert! connection table record-data jdbc/snake-kebab-opts)))
```


Refactor the `practicalli.database-access/update-record` function

```clojure
(defn update-record
  "Insert a single record into the database using a managed connection.
  Arguments:
  - table - name of database table to be affected
  - record-data - Clojure data representing a new record
  - db-spec - database specification to establish a connection
  - where-clause - column and value to identify a record to update"
  [db-spec table record-data where-clause]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/update! connection table record-data where-clause jdbc/snake-kebab-opts)))
```


## Disparity between spec namespace and database design
A qualified keyword is where that keyword has a namespace, eg. `:practicalli/name` rather than `:name`

Using qualified keywords is recommended so that they can be unique across the application (and ideally multiple applications).

When using a database, the table name can be used to qualify the results returned from queries to the database.  However, if the table names are different to the clojure.spec specification then it is harder to test

![keyword disparity](/images/clojure-webapps-database-testing-keywords-qualified-database-name.png)

To resolve this issue, either the specifications should be refactored or the database names.  I suspect probably both would benefit from some redesign now experience has been gained in using them.
