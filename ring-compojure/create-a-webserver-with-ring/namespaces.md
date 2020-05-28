# Theory: Namespaces
  A namespace in Clojure is used to manage the logical separation of code, usually along features of the application.  A namespace limits the scope of functions and names of data structures to a specific namespace.

  The names bound to function definitions using the `defn` function can be used elsewhere in the namespace just by using the name.  The same goes for any values bound to a name using the `def` function.

> ####Hint::Clojure order of evaluation
> The code in a Clojure namespace is evaluated only once and from top to bottom.  To call a named function or data structure, it must have its definition evaluated first.

  To use a function outside the namespace, you need to use its namespace and its name, for example `clojure.string/reverse`

## Include another namespace in the REPL

  The `require` function will provide access functions and names from specific namespaces and an alias for the namespace can also be specified with the `:as` directive.

  A function from that namespace can then be used by prefixing its name with the alias specified in the `require` expression.

  Here is an example of including the `clojure.string` namespace and calling its `reverse` fuction

```
(require '[clojure.string :as string])

(string/reverse "RedRum")
```


## Including another namespace in source code

  Instead of the `require` function, add the `:require` keyword in the namespace definition, `ns`.

```
(ns todo-list.core
 (:require '[clojure.string :as string))

(string/reverse "RedRum")
```

  If a funciton will be used many times in the namespace, you can `:refer` a function so you can call it just by name, as if it had been defined in the current namespace.

```
(ns todo-list.core
 (:require '[clojure.string :refer [reverse]))

(reverse "RedRum")
```

  If you are using most functions from another namespace, you could `:refer :all`.  However, use this sparingly as it could lead to functions over-riding each other.

```
(ns todo-list.core
 (:require '[clojure.string :refer :all))
```

> ####Hint::Dependency conflicts - avoid the `use` function
> The `use` function and `:use` within an `ns` definition are seen as a bad practice and should be avoided.
>
> The `use` function includes all the functions as if they had been written in the  including a great many unused functions into the namespace.  It will also pull in all the other namespace functions that each namespace included.
>
> As Clojure is typically composed of many libraries, its prudent to only include the specific things you need from another namespace.  This also helps reduce conflicts when including multiple libraries in your project.


## Namespaces outside the project
  To use a namespace from a library that is not part of the project, you also need to include it as a dependency.  We saw in [add ring dependency](add-ring-dependency.html) how to add a library as a `:dependency` in the Leiningen `project.clj` file.
