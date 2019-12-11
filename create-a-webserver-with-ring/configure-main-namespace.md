# Configure main namespace

Setting the default namespace will automatically call a function called `-main` when the Clojure project is run, i.e. via `lein run`

> #### Note::Add main namespace
>Edit the `project.clj` file and add `:main todo-list.core` configuration option.
>
```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}
  :dependencies [[org.clojure/clojure "1.10.1"]
                 [ring "1.8.0"]]
  :repl-options {:init-ns todo-list.core}
  :main todo-list.core)
```
