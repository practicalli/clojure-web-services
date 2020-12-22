# Create database records
Several options were explored when designing database query functions.  Using next.jdbc.sql functions provides a Clojure data structures approach, where as `next.jdcbc/execute!` uses specific SQL statement code.

Take the SQL approach if generating SQL statements directly.

Take the Clojure approach if to generate SQL statements from Clojure data structures.

{% tabs clojure="next.jdbc.sql functions", sql="next.jdbc/execute!"  %}

{% content "clojure" %}

## Generic create record function
Use the generic create function from the database schema design section

```clojure
(defn create-record
  "Insert a single record into the database using a managed connection.
  Arguments:
  - table - name of database table to be affected
  - record-data - Clojure data representing a new record
  - db-spec - database specification to establish a connection"
  [db-spec table record-data]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/insert! connection table record-data)))
```


## Create a new account_holder record
Call the `create-record` function with the development database specification, the account holder table name and a Clojure hash-map of the record data.

Each key in the map represents a column name and the value associated with the key is the value to be inserted in the record for its column.

```clojure
(create-record db-specification-dev
               "public.account_holders"
               {:account_holder_id      (java.util.UUID/randomUUID)
                :first_name             "Rachel"
                :last_name              "Rocketpack"
                :email_address          "rach@rocketpack.org"
                :residential_address    "1 Ultimate Question Lane, Altar IV"
                :social_security_number "BB104312D"})
```

## Create account record
Create a new record in the `public.accounts` table.

```clojure
(create-record db-specification-dev
               "public.accounts"
               {:account_id        (java.util.UUID/randomUUID)
                :account_number    "1234567890"
                :account_sort_code "102010"
                :account_name      "Current"
                :current_balance   100
                :last_updated      "2020-09-11"
                :account_holder_id (java.util.UUID/randomUUID)})
```

## Create transaction record
Create a record in the `public.transaction_history` table.

```clojure
(create-record db-specification-dev
               "public.transaction_history"
               {:transaction_id        (java.util.UUID/randomUUID)
                :transaction_reference "Salary"
                :transaction_date      "2020-09-11"
                :account_number        "1234567890"})
```


{% content "sql" %}


## Insert account_holders


## Insert accounts


## Insert transactions



{% endtabs %}


> #### Hint::Generating example data from Clojure Spec
> [Clojure Spec: generate mock database data](clojure-spec-generate-mock-data.md)
