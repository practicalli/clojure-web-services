# Including Ring in the Namespace

Add the `ring-adaptor-jetty` namespace from the ring library, so we can use the functions from that library.

> ####NOTE::Require the ring-adaptor
> Delete all code in `src/todo_list/core.clj` and replace it with the following code.
>
```clojure
(ns todo-list.core
  (:require [ring.adapter.jetty :as webserver]))
```

The `ns` expression defines the current namespace as `todo-list.core`, providing a scope for all the functions and data structures we define within it.

The `:require` expression makes the `ring.adaptor.jetty` namespace accessible within the `todo-list.core` namespace.  We can now call any of the public functions in the `ring.adaptor.jetty` namespace.

In `ring.adapter.jetty` namespace is bound to the `webserver` alias, providing a short name to refer to functions from that namespace.

For example, the `run-jetty` function is called using `webserver/run-jetty` rather than the fully qualified namespace of `ring.adaptor.jetty/run-jetty`

> ####Hint::Using aliases for namespaces
> Using `:require` we can use the `:as` keyword to specify an alias for a namespace, a short-hand way of refering to a library.  You can specify any valid Clojure name for a namespace alias, however please consider the readability of your code and choose a meaningful alias name.
>
> Later in the workshop we will show other options for including functions from other namespaces.
