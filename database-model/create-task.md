# Create a task

Lets write a function to create tasks in the database

```clojure 
(defn create-task [task-name]
  (sql/insert! postgres
               :tasks [:body] [task-name])
  (println task-name))
```

