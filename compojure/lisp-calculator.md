# Simple Calculator

  Lets create a very simple lisp based calculator that works with two numbers as another example of using variable path elements.  As its a Lisp calculator, then we will use prefix notation (the 'operator' comes first)
  
> **Note**  Create a route for the calculator 
  
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

> **Note** Create a handler function to add, subtract, divide or multiply two numbers

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

> **Note**  Define a map called operands to match the string names of the mathematical operations (operands) to the actual functions in clojure 

```clojure
(def operands {"+" + "-" - "*" * ":" /})
```

--- 

## All put togehter this looks like

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
  (GET "/" [] greet)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] handle-dump)
  (GET "/yo/:name" [] yo)
  (GET "/calculator/:a/:op/:b" [] calculator)
  (not-found "Sorry, page not found"))
```

  Try the calculator out like follows http://localhost:8000/calculator/2/+/3
  
  
--- 

## Complete code so far

  Get the complete code so far from the branch `04-compojure`
  
  ```
  git checkout 04-compjure
  ```
  
  If you havent got the repo already, get it by 

```bash
  git clone http://practicalli.github.io/clojure-webapps-example
```
