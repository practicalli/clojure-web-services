## Theory: Local assignment with Let

The `let` function creates a name (alias) for some valuable within the scope of the let function.  The name and value are immutable.

```clojure
(let [name value])
```

In our example we are pulling out a value from a map and using the `let` function to create a name we can use to reference that value.  The name is used to in the body of the response map, so when the response map is returned the page is displayed with the name.

```clojure
(let [name (get-in request [:route-params :name])]
    {:status 200
     :body (str "Hello " name ".  I got your name from the web URL")
     :headers {}})
```

The Ring adaptor creates a map from the browser request, this is called the request map.  This request map is passed to the handler function.
