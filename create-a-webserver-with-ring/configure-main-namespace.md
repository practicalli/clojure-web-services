# Configure main namespace

> ####Note:: Set the default namespace for the Clojure project.

Edit the `project.clj` file and add `:main todo-list.core` configuration option.

Setting the default namespace will automatically call a function called `-main` when the Clojure project is run, i.e. via `lein run`

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A simple webapp using Ring"
  :url "http://example.com/FIXME"

  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}

  :dependencies
    [[org.clojure/clojure "1.10.0"]
     [ring                "1.7.1"]]

  :main todo-list.core)
```
