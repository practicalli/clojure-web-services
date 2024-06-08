# Show all tasks

Write a function to list all the tasks in the database, limited to the first 128 items


```clojure
(defn all-tasks []
  (into [] (sql/query postgres ["select * from tasks order by id desc limit 128"])))
```

