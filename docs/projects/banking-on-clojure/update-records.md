# Update Records in the database

Several options were explored when designing database query functions.  Using next.jdbc.sql functions provides a Clojure data structures approach, where as `next.jdbc/execute!` uses specific SQL statement code.

Take the SQL approach if generating SQL statements directly.

Take the Clojure approach if to generate SQL statements from Clojure data structures.


## Generic update record function

Use the generic create function from the database schema design section

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
    (jdbc-sql/update! connection table record-data where-clause)))

```


## Update an existing account_holder record

Call the `update-record` function with the development database specification, the account holder table name and a Clojure hash-map of the record data.

Each key in the map represents a column name and the value associated with the key is the value to be inserted in the record for its column.

```clojure
  (update-record db-specification-dev
                 :public.account_holders
                 {:EMAIL_ADDRESS "rachel+update@rockketpack.org"}
                 {:account_holder_id "f6d6c3ba-c5cc-49de-8c85-21904f8c5b4d"})
```

If the update is successful then `:update-count 1` value is returned

```clojure
  ;; => #:next.jdbc{:update-count 1}
```

## Update an existing account record

Update an existing record in the `public.accounts` table, providing new values for `current_balance` and `last_updated` columns.

```clojure
(update-record db-specification-dev
               "public.accounts"
               {:current_balance   242
                :last_updated      "2020-09-12"}
               {:account_number "1234567890"})
```

## Update an existing transaction record

Update an existing record in the `public.transaction_history` table.

```clojure
(update-record db-specification-dev
               "public.transaction_history"
               {:transaction_reference "Salary bonus"
                :transaction_date      "2020-09-12"}
               {:transaction_id  "8ac89cfc-6874-4ebe-9ee4-59b8c5e971ff"})
```


!!! HINT "Generating example data from Clojure Spec"
    [Clojure Spec: generate mock database data](clojure-spec-generate-mock-data.md){target=_blank}
