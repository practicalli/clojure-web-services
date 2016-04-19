# Variable Path Elements

A simple way to affect the behaviour of a web app is to add extra text (elements) to the web address (URL).  For example, you can add your name to the end of the web address and the returned web page will include your name.

  By adding an element to the route path, we can take that element from the URL as it is part of the request.  We can then get that value from the request map and use it in our body content.

> **Note**  Create a simple personalised hello message by adding a route for `/hello` with `/:name` as a path element.

> Create a `hello` function as the handler that pulls out the `:name` element from the request and adds it to the response.

```clojure
(defn hello
  "A simple personalised greeting showing the use of variable path elements"
  [request]
  (let [name (get-in request [:route-params :name])]
    {:status 200
     :body (str "Hello " name ".  I got your name from the web URL")
     :headers {}}))

(defroutes app
  (GET "/" [] greet)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] handle-dump)
  (GET "/hello/:name" [] hello)
  (not-found "Sorry, page not found"))
```

  Now you can test this route out by also including a name to the URL path http://localhost:8000/hello/john

<hr />

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

## Theory: Accessing Maps 

The request is a Clojure map made up of keys and values.  The keys are Clojure keywords.  Some of the values in a map are also represented as maps

Here is an example of a request map 

```clojure 
{:request-params {:name "John"}}
```

Using the `get` function we can pull out the value for a particular keyword in the map 

```clojure
(get map :keyword)
```

You can use `get` with a nested map, however you would need a nested `get` funciton call

```clojure
(get (get outer-map :outer-keyword) :inner-keyword)
```

With many nested maps, the `get` function can lead to code that is harder to read.  Using the `get-in` function provides a simpler syntax for traversing nested maps


```clojure
(get-in map [:outer-keyword :inner-keyword]
```


## Theory: Using keywords and maps 

You can also use keywords to extract values from maps when using the keywords as the keys 

```clojure
(def response-map {:name "john" :path "/helo"}
```

You can get the value from this map using the keywork

```clojure
(response-map :name)

=> "john"

(response-map :path)

=> "/hello"
```
