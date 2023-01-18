# Theory: if function

Clojure has an `if` function that evaluates an expresssion.  If that expression is true, then the first value is returned, if false then the second argument is returned.

In pseudo-code, the `if` function in Clojure works as follows

```basic
  If (this expression is true ?)
    then return this value
    else return this value
```

In the project code an `if` function checks the web address by returning the value associated with `:uri` in the request map.

If the `:url` value is equal to `/` then the first response map with the hello message is returned.

If the `:uri` value is not equal to `/` then the second resource map with an error message is returned.


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


> ####Hint::Single path if function
> In the case where an if expression is defined with only one value and the expression is false, then the value `nil` is returned.  `when` function is the idiomatic choice over a single path `if` function.


## Multiple expression if function with do
Each of the two possible values the `if` function returns can come from only evaluating one expression.  For example

```clojure
(if (true)
  (str "I am the truth")
  (str "I am the path to darkness")
```

If you need multiple expressions they can be wrapped in the `do` function

```clojure
(if (true)
  (do (some-function)
      (another-function))
  (else-function))
```

The `do` function calls each function evaluation in turn, returning the result of the last function called.

> ####Hint::Compojure for managing routes
> The `if` function is a very simplistic way to define routes in our web application.  Compojure is a library for elegantly managing routing for our Clojure server-side applications.
