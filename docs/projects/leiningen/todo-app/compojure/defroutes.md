# Theory: defroutes is a Clojure macro

  The Compojure function `defroutes` is actually a Clojure macro.  The `defroutes` macro provides a simple syntax for defining routes and associating handler functions.

## What is a macro?

Clojure has a programmatic macro system which allows the Clojure community to extend the language, rather than wait for the language designers.  This macro approach also helps keep the language very compact, with a minimum of primitives.

We have already used several macros in our code.  In our project.clj configuration we use the `defproject` macro to make it easy to define our Clojure project.  In our code we have used the `defn` macro to define names (symbols) for functions.

## Peeking under the covers

You can always look at what a macro is doing by using the `macroexpand` or `macroexpand-all` functions.  These functions show you what the code looks like after the macro-reader has processed the macro.

To expand a macro, require the `clojure.walk` library in your namespace

```clojure
[clojure.walk :as walk]
```

Then wrap the macro you wish to explore with the `macroexpand-all` function.

```clojure
(walk/macroexpand-all
 '(defroutes myapp
    (GET "/" [] "Show something")))


(def myapp
  (compojure.core/routes
   (compojure.core/make-route
    :get #clout.core.CompiledRoute{:source "/", :re #"/", :keys [], :absolute? false}
    (fn* ([request__13075__auto__] (let* [] "Show something"))))))
```

You can see that the `defroutes` function expands to a `make-route` function that creates the details of the route and associates it with a handler or response map.
The `routes` function join multiple routes together.

For further examples, see http://learnxinyminutes.com/docs/clojure-macros/
