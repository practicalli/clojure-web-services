# Theory: routing

In compojure, each route is a combination offer a HTTP method paired with a URL-matching pattern, an argument list, and a handler.  The handler is typically the name of function.

```clojure
(defroutes myapp
  (GET     "/" [] show-something)
  (POST    "/" [] create-something)
  (PUT     "/" [] replace-something)
  (PATCH   "/" [] modify-something)
  (DELETE  "/" [] annihilate-something)
  (OPTIONS "/" [] appease-something)
  (HEAD    "/" [] preview-something))
```

A handler is a functions which accept request maps and return response maps.

```clojure
(defn show-something
  "A simple handler function"
  [request]
  {:status 200
   :headers {"Content-Type" "text/html; charset=utf-8}
   :body "<h1>I am a simple handler funciton</h1>"})
```

These handler functions can be called by passing a Clojure hash-map.  The result is another Clojure hash-map that contains values for `:status`, `:headers` and `:body`.

```clojure
(show-something {:uri "/" :request-method :post})
;; => {:status 200
;;     :headers {"Content-Type" "text/html; charset=utf-8}
;;     :body "<h1>I am a simple handler funciton</h1>"}
```

The body may be a function, which must accept the request as a parameter:

```clojure
(defroutes myapp
  (GET "/" [] (fn [req] "Do something with req")))
```

Or, you can just use the request directly:

```clojure
(defroutes myapp
  (GET "/" req "Do something with req"))
```

Route patterns may include named parameters:

```clojure
(defroutes myapp
  (GET "/hello/:name" [name] (str "Hello " name)))
```

You can adjust what each parameter matches by supplying a regex:

```clojure
(defroutes myapp
  (GET ["/file/:name.:ext" :name #".*", :ext #".*"] [name ext]
    (str "File: " name ext)))
```
