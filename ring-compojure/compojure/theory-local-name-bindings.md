## Theory: Local binding with `let`
The `let` function binds a name to a value within the scope of the `let` function.  The name is used to represent the value it is bound to, especially useful if the value is complex or the result of an expression.

```clojure
(let [name value])
```

Binding values to names can be used to remove duplicate code, making the code more efficient.

## Binding any value
A let expression can bind a name to any Clojure value, from a simple number or string, to a collection or result of an expression.

In our example we are pulling out a value from a map and using the `let` function to create a name we can use to reference that value.  The name is used to in the body of the response map, so when the response map is returned the page is displayed with the name.

```clojure
(let [name (get-in request [:route-params :name])]
    {:status 200
     :body (str "Hello " name ".  I got your name from the web URL")
     :headers {}})
```

The Ring adaptor creates a Clojure hash-map from the browser request which is called the request map.  The request map is passed to handler functions.


## A binding is immediately available
A name is available for use as soon as it is bound, even within the name/value bindings section of the `let` expression.

```eval-clojure
(let [apples  10
      oranges 15
      total-fruit (+ apples oranges)]
  (str "Total fruit: " total-fruit))
```


> #### Hint::Use meaningful names or avoid local names
> Use meaningful names in let expressions to effectively communicate the purpose of the code.
>
> If it is hard to find a meaningful name, either the problem space is not understood enough or local names may not be necessary.
