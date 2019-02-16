# Including Ring in the Namespace

> ####Note:: Include the Ring library in the `todo-list.core` namespace

Delete all the code in `src/todo_list/core.clj` and replace it with the following code, adding the ring adaptor for Jetty to our project.

```clojure
(ns todo-list.core
  (:require [ring.adapter.jetty :as jetty]))
```

This expression defines the current namespace as `todo-list.core`, providing a scope for all the functions and data structures we define within it.

The `:require` expression makes the `ring.adaptor.jetty` namespace accessible within the `todo-list.core` namespace.  We can now call any of the public functions in the `ring.adaptor.jetty` namespace.  We defined an alias called `jetty`, so we can call the `run-jetty` function using `jetty/run-jetty` rather than the fully qualified namespace of `ring.adaptor.jetty/run-jetty`

> ####Hint:: Using `:require` we can add one or more libraries to our namespace.  We can also use the `:as` keyword to specify a short-hand way of refering to a library.  You can specify any valid Clojure name for a namespace alias, however please consider the readability of your code and choose a meaningful alias.

> Later in the workshop we will show other options for including functions from other namespaces.
