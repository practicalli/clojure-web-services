# Defining Database Queries

Using the SQL statement for Inserting records as an example, several different approached are covered for defining database queries.  The options are similar for update and delete queries.

All options use the `with-open` function to wrap the connection to the database, to automatically close that connection once the function has completed.

| Approach                                          | Description                                                                                     |
|---------------------------------------------------|-------------------------------------------------------------------------------------------------|
| `next.jdbc/execute!` function                     | Simple approached used previously for creating tables                                           |
| Defining a generic function                       | Pass SQL statements and connection into a single function, using `def` to define sql statements |
| `next.jdbc.sql/*` functions                       | Generate SQL statements from Clojure data structures, e.g. hash-maps, vectors, etc.             |
| Generic function with `next.jdbc.sql/*` functions | Generic insert, update and delete functions that take a Clojure data structures                 |


## Example SQL queries from DBeaver

Using the DBeaver tool the basic form of an insert command is generated from **Generate SQL > DDL**

```sql
INSERT INTO PUBLIC.ACCOUNT_HOLDERS
 (ACCOUNT_HOLDER_ID, FIRST_NAME, LAST_NAME, EMAIL_ADDRESS, RESIDENTIAL_ADDRESS, SOCIAL_SECURITY_NUMBER)
VALUES(?, '', '', '', '', '');
```


## Using the general execute! command

Using the general jdbc/execute! is the same form as used previously to create, show and drop database tables.

```clojure
(defn persist-account-holder
  "Persist a new account holder record"
  [account-holder-id db-spec]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc/execute!
      connection
      [(str "insert into account_holders(
               account_holder_id,first_name,last_name,email_address,residential_address,social_security_number)
             values(
               '" account-holder-id "', 'Jenny', 'Jetpack', 'jen@jetpack.org', '42 Meaning Lane, Altar IV', 'AB101112C' )")])) )
```

Call the function with a randomly generated UUID value for the `account_holder_id` and the database details in the form of the development database specification.

```clojure
(persist-account-holder (java.util.UUID/randomUUID) db-specification-dev)
```

## Using a generic function approach

Write a Clojure function that takes in any SQL statement and executes that against a specific database specification.

```clojure
(defn database-update
  [sql-statement db-spec ]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc/execute! connection sql-statement)))
```

Refactor sql statements into their own vars, so they can be reused.

```clojure
(def account-holder-jenny
  [(str "insert into account_holders(account_holder_id,first_name,last_name,email_address,residential_address,social_security_number)
    values('" (java.util.UUID/randomUUID) "', 'Jenny', 'Jetpack', 'jen@jetpack.org', '42 Meaning Lane, Altar IV', 'AB101112C' )")])
```

Update the database using the name of the SQL statement

```clojure
(database-update account-holder-jenny db-specification-dev)
```

> #### Hint::limitation of def
> The `def` expression must be evaluated each time a new value for the account_holder_id is required.  The first time the `def` is evaluated, the `java-util.UUID/randomUUID` function is evaluated to a specific value and that value is cached.
> Using the `account-holder-jenny` name in other code will use the cache until the `def` expression is forcefully evaluated (by the developer or by restarting the REPL).


## Using next.jdbc friendly functions

Using next.jdbc.sql functions.  For example:

```clojure
(jdbc-sql/insert! ds :address {:name "A. Person" :email "albert@person.org"})
```

For the banking-on-clojure project this would take the form

```clojure
(defn add-account-holder
  [account-holder-id data-source]
  (jdbc-sql/insert!
    data-source
    :table-name {:column-name "value" ,,,}))
```

In this example, the next.jdbc insert! function is used to add an account holder record.

```clojure
(defn add-account-holder
  [account-holder-id db-spec]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert!
      connection
      :public.account_holders {:account_holder_id      account-holder-id
                               :first_name             "Rachel"
                               :last_name              "Rocketpack"
                               :email_address          "rach@rocketpack.org"
                               :residential_address    "1 Ultimate Question Lane, Altar IV"
                               :social_security_number "BB104312D"})))
```

Calling the function with generated data.

```clojure
(add-account-holder (java.util.UUID/randomUUID) db-specification-dev)
```


## Generic insert function with next.jdbc.sql

```clojure
(defn insert-record
  [table record-data db-spec]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert! connection table record-data)))
```

The data to pass in looks familiar. Its the table name plus a data structure that looks like a specification for an account holder.

```clojure
:public.account_holders

{:account_holder_id      (java.util.UUID/randomUUID)
 :first_name             "Rachel"
 :last_name              "Rocketpack"
 :email_address          "rach@rocketpack.org"
 :residential_address    "1 Ultimate Question Lane, Altar IV"
 :social_security_number "BB104312D"}
```

So the [specifications already defined](spec-generative-testing.md) can be used to generate mock data for the database.
