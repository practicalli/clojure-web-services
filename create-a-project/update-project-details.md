# Update project details

Although its optional for this exercise, its very useful to add details about the project so others know what its about (and for yourself when you havent worked on it for a while).

## Update the project licence 

By default Clojure projects are given the Eclipse Public License.  This may not always be suitable for all, so you could update the LICENCE file contents and the `project.clj` file `:licence` declaration.

> **Note** Update the `project.clj` file to use the MIT Licence 

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "MIT License"
            :url "https://opensource.org/licenses/MIT"}
  :dependencies [[org.clojure/clojure "1.8.0"]])

```

## Update the project readme

By adding a description of the project in the `README.md` file is a simple way for everyone to understand what the project is about.  It is also common to provide details on how to run the project or use it as a library.
