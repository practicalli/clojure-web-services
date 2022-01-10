# Lisp style Calculator

Lets create a very simple lisp based calculator that works with two numbers as another example of using variable path elements.  As its a Lisp calculator, then we will use prefix notation (the 'operator' comes first)

## Create a route for the calculator

```clojure
(defroutes app
  (GET "/" [] greet)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] handle-dump)
  (GET "/hello/:name" [] hello)
  (GET "/calculator/:op/:a/:b" [] calculator)
  (not-found "Sorry, page not found"))
```


## Create a handler function to add, subtract, divide or multiply two numbers

```clojure
(defn calculator
  "A very simple calculator that can add, divide, subtract and multiply.  This is done through the magic of variable path elements."
  [request]
  (let [a  (Integer. (get-in request [:route-params :a]))
        b  (Integer. (get-in request [:route-params :b]))
        op (get-in request [:route-params :op])
        f  (get operands op)]
    (if f
      {:status 200
       :body (str "Calculated result: " (f a b))
       :headers {}}
      {:status 404
       :body "Sorry, unknown operator.  I only recognise + - * : (: is for division)"
       :headers {}})))
```

## Create a dictionary to look up Clojure function names

Define a hash-map called `operands` to look up the names of the mathematical operations (operands) to the actual functions in Clojure

```clojure
(def operands {"+" + "-" - "*" * ":" /})
```

Try the calculator out like follows http://localhost:8000/calculator/*/6/7


## The namespace with changes made

With all the changes from above, the code should look as follows

```clojure
(def operands {"+" + "-" - "*" * ":" /})

(defn calculator
  "A very simple calculator that can add, divide, subtract and multiply.  This is done through the magic of variable path elements."
  [request]
  (let [a  (Integer. (get-in request [:route-params :a]))
        b  (Integer. (get-in request [:route-params :b]))
        op (get-in request [:route-params :op])
        f  (get operands op)]
    (if f
      {:status 200
       :body (str (f a b))
       :headers {}}
      {:status 404
       :body "Sorry, unknown operator.  I only recognise + - * : (: is for division)"
       :headers {}})))

(defroutes app
  (GET "/" [] welcome)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] handle-dump)
  (GET "/yo/:name" [] yo)
  (GET "/calculator/:op/:a/:b" [] calculator)
  (not-found "Sorry, page not found"))
```
