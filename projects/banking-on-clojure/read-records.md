# Read Database Records
Using `next.jdbc.sql` functions provides a Clojure data structures approach, where as `next.jdcbc/execute!` uses specific SQL statement code.


{% tabs clojure="next.jdbc.sql functions", sql="next.jdbc/execute!"  %}

{% content "clojure" %}

## Generic read record function
Use the generic create function from the database schema design section

```clojure
(defn read-record
  "Insert a single record into the database using a managed connection.
  Arguments:
  - table - name of database table to be affected
  - record-data - Clojure data representing a new record
  - db-spec - database specification to establish a connection"
  [db-spec sql-query]
  (with-open [connection (jdbc/get-connection db-spec)]
    (jdbc-sql/query connection sql-query)))
```


## Read account_holder records
Call the `read-record` function with the development database specification and a Clojure vector containing a string of the SQL select statement.

Return all the records from a specific table

```clojure
  (read-record db-specification-dev ["select * from public.account_holders"])
```

Return records that match a specific where clause

```clojure
  (read-record db-specification-dev ["select * from public.account_holders where first_name = ?" "Rachel"])
```

## Read account records
Create a new record in the `public.accounts` table.

Return all the records from a specific table

```clojure
  (read-record db-specification-dev ["select * from public.accounts"])
```

Return records that match a specific where clause

```clojure
  (read-record db-specification-dev ["select * from public.accounts where account_number = ?" "1234567890"])
```

## Read transaction history records
Create a record in the `public.transaction_history` table.

```clojure
  (read-record db-specification-dev ["select * from public.transaction_history"])
```

Return records that match a specific where clause

```clojure
  (read-record db-specification-dev ["select * from public.transaction_history where transaction_date = ?" "2020-09-11"])
```


{% content "sql" %}


## Insert account_holders


## Insert accounts


## Insert transactions



{% endtabs %}


> #### Hint::Generating example data from Clojure Spec
> [Clojure Spec: generate mock database data](clojure-spec-generate-mock-data.md)
