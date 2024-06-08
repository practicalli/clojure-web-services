# Delete Records in the database
Using `next.jdbc.sql` functions provides a Clojure data structures approach, where as `next.jdbc/execute!` uses specific SQL statement code.

{% tabs clojure="next.jdbc.sql functions", sql="next.jdbc/execute!"  %}

{% content "clojure" %}

## Generic delete record function
Use the generic delete function from the database schema design section

```clojure
(defn delete-record
  "Insert a single record into the database using a managed connection.
  Arguments:
  - table - name of database table to be affected
  - record-data - Clojure data representing a new record
  - db-spec - database specification to establish a connection"
  [db-spec table where-clause]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/delete! connection table where-clause)))
```


## Delete an existing account_holder record
Call the `delete-record` function with the development database specification, the table name and a where clause to locate the specific record to delete.  This where clause should use a unique value, e.g. the primary key for the table.

```clojure
  (delete-record db-specification-dev :public.account_holders {:account_holder_id "0bed6afe-6740-46a1-b924-36ef192eac66"})
```

If the record deletion is successful then `:update-count 1` value is returned

```clojure
  ;; => #:next.jdbc{:update-count 1}
```

## Deleting an existing account record
Update an existing record in the `public.accounts` table, providing new values for `current_balance` and `last_updated` columns.

```clojure
(delete-record db-specification-dev :public.accounts {:account_number "1234567890"})
```

## Deleting an existing transaction record
Update an existing record in the `public.transaction_history` table.

```clojure
(delete-record db-specification-dev :public.transaction_history {:transaction_id  "8ac89cfc-6874-4ebe-9ee4-59b8c5e971ff"})
```


{% content "sql" %}


## Insert account_holders


## Insert accounts


## Insert transactions



{% endtabs %}


> #### Hint::Generating example data from Clojure Spec
> [Clojure Spec: generate mock database data](clojure-spec-generate-mock-data.md)
