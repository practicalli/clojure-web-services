# Variable Path Elements

A simple way to affect the behaviour of a web app is to add extra text (elements) to the web address (URL).  For example, you can add your name to the end of the web address and the returned web page will include your name.

By adding an element to the route path, we can take that element from the URL as it is part of the request.  We can then get that value from the request map and use it in our body content.

## Hello handler example

Create a simple personalised hello message by adding a route for `/hello` with `/:name` as a path element.

Create a `hello` function as the handler that pulls out the `:name` element from the request and adds it to the response.

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
