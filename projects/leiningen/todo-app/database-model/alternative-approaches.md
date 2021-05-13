# Alternative approaches

> ####Hint:: Here is an alterative approach to the code just created, for comparison purposes only.  There is no need to implement any of the following code (unless you prefer this approach)



## Using UUID-OSSP Postgres plugin

The UUID-OSSP extension to our Heroku postgres database to autogenerate universal ID's (UUID).  These UUID's are managed by postres and therefore not resistant to braking from code.  The database memory overhead for UUID's is typically less than using text based ID's

```clojure
(defn create-table [db]
  (db/execute!
   db
   ["CREATE EXTENSION IF NOT EXISTS \"UUID-OSSP\"" ])
  (db/execute!
   db
   ["CREATE TABLE IF NOT EXISTS items
      (id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
       name TEXT NOT NULL,
       description BOOLEAN NOT NULL DEFAULT FALSE,
       date_created TIMESTAMPTZ NOT NULL DEFAULT now()"]))
```

> **Fixme** What is the clojure.java.jdbc version of the above ?


## Add more database functions


```clojure
(defn create-item [db name description]
  (:id (first (db/query
               db ["INSERT INTO items (name, description)
                    VALUES (?, ?)
                    RETURN id"
                   name
                   description]))))

(defn update-item [db id checked]
  (= [1] (db/execute!
          db
          ["UPDATE items
            SET checked = ?
            WHERE id = ?"
           checked
           id])))

(defn delete-item [db id]
  (= [1] (db/execute!
          db
          ["DELETE FROM items
            WHERE id = ?"
           id])))

(defn read-items [db]
  (db/query
   db
   ["SELECT id, name, description, checked, date_created
     FROM items
     ORDER BY date_created"]))
```
