# Create table

> #### Hint::Recommend using next.jdbc
> next.jdbc is the next generation of clojure.java.jdbc and is recommended instead.  The API is very similar, although with many improvements

We have our database model for tasks, so lets create write some code that will create a database table in Postgres, assuming that table is not there already.


## Create items namespace

Create a new Clojure file `src/todo_list/items.clj` and add the following code

First add a dependency for Clojure.java.jdbc

```clojure
[clojure.java.jdbc :as sql]
```

You `items.clj` should look like

```clojure
(ns todo-list.items
  (:require [clojure.java.jdbc :as sql]))
```

We only want to create the database if it does not already exist, so we can check if the table is already part of the schema

```clojure
(defn db-schema-migrated?
  "Check if the schema has been migrated to the database"
  []
  (-> (sql/query postgres
                 [(str "select count(*) from information_schema.tables "
                       "where table_name='tasks'")])
      first :count pos?))
```

Then add a condition to check if the table exists and if not then create the database table

```clojure
(defn apply-schema-migration
  "Apply the schema to the database"
  []
  (when (not (db-schema-migrated?))
    (sql/db-do-commands postgres
                        (sql/create-table-ddl
                         :tasks
                         [:id :serial "PRIMARY KEY"]
                         [:body :varchar "NOT NULL"]
                         [:created_at :timestamp
                          "NOT NULL" "DEFAULT CURRENT_TIMESTAMP"]))))
```


## What Heroku does when you create a database

Heroku Postgres users are granted all non-superuser permissions on their database. These include `SELECT, INSERT, UPDATE, DELETE, TRUNCATE, REFERENCES, TRIGGER, CREATE, CONNECT, TEMPORARY, EXECUTE,` and `USAGE`.

Heroku runs the SQL below to create a user and database for you.

You cannot create or modify databases and roles on Heroku Postgres. The SQL below is for reference only.

```sql
CREATE ROLE user_name;
ALTER ROLE user_name WITH LOGIN PASSWORD 'password' NOSUPERUSER NOCREATEDB NOCREATEROLE;
CREATE DATABASE database_name OWNER user_name;
REVOKE ALL ON DATABASE database_name FROM PUBLIC;
GRANT CONNECT ON DATABASE database_name TO database_user;
GRANT ALL ON DATABASE database_name TO database_user;
```
