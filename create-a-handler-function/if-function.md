# Theory: if function 

Clojure has an `if` function that evaluates an expresssion.  If that expression is true, then the first value is returned, if false then the second argument is returned.

In psudo-code, the `if` function in Clojure works as follows

```
  If (this expression is true ?)
    then return this value
    else return this value
```

In our code, if the web address, `:uri`, taken from the request map is equal to `/` then the first response map with the hello message is returned.  If the `:uri` value is not equal to `/` then the second resource map with an error message is returned.


```clojure
  (if (= "/" (:uri request))
    {:status 200
     :body "<h1>Hello, Clojure World</h1>
            <p>Welcome to your first Clojure app.</p>"
     :headers {}}
    {:status 404
     :body "<h1>This is not the page you are looking for</h1>
            <p>Sorry, the page you requested was not found!></p>"
     :headers {}}))
```


> **Hint** In the case where an if expression is defined with only one value and the expression is false, then the value `nil` is returned.

## Advanced if functions with do

Each of the two possible values the `if` function can return can come from evaluating a function.  For example

```
(if (true)
  (str "I am the truth")
  (str "I am the path to darkness") 
```

However, each value can only be defined by one expression.  If you need to have multiple steps you can use a function called `do`


```
(if (true)
  (do (some-function)
      (another-function))
  (else-function))
```

The `do` function calls each function evaluation in turn, returning the result of the last function called. 

> **Hint** The if function is a very simplistic way to define routes in our web application.  Soon we will look at Compojure, a library for elegantly managing routing for our Clojure application.

