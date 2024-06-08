# Add Compojure as a dependency

Edit your project configuration `project.clj` and add the [current version of Compojure](https://clojars.org/compojure)

The `project.clj` file should look as follows:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}
  :dependencies [[org.clojure/clojure "1.10.1"]
                 [ring "1.8.0"]
                 [compojure "1.6.1"]]
  :repl-options {:init-ns todo-list.core}
  :main todo-list.core
  :profiles {:dev
             {:main todo-list.core/-dev-main}})
```

As we are adding a library to the project we need to restart the web server.

`Ctrl-c` in the terminal to stop the server and `lein run 8000` to restart the web server


> ####Hint::Search clojars.org for dependency versions
> The [current version of Compojure](https://clojars.org/compojure) or any other Clojure library can be found via [Clojars.org](https://clojars.org/).
