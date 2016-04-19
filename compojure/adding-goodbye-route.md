# Adding a goodbye route

> **Note** Add another route to display a goodbye message
  
```clojure
(defroutes app
  (GET "/" [] welcome)
  (GET "/goodbye" [] goodbye)
  (not-found "Sorry, page not found"))
```

  
> **Note** Dont forget to write the handler function for the `goodbye` route


```clojure
(defn goodbye
  "A song to wish you goodbye"
  [request]
  {:status 200
   :body "<h1>Walking back to happiness</h1>
          <p>Walking back to happiness with you</p>
          <p>Said, Farewell to loneliness I knew</p>
          <p>Laid aside foolish pride</p>
          <p>Learnt the truth from tears I cried</p>"
   :headers {}})
```
  
> **Note** Now [test your new route](http://localhost:8000/goodbye).  As we have `wrap-reload` around app then no restart needed

