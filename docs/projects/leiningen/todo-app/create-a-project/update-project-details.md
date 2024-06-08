# Update project details

Adding project details to the `project.clj` file helps every developer that works with the code to have a basic understanding of the projects purpose.

> #### Note::Update project details
> Edit the `project.clj` file and make the following changes.
>
* Add a description
* Add the URL of the project, eg. the github repository
* Update the licence (optional)
* Update the dependencies to the latest Clojure version
>
>
> The project.clj file for Practicalli projects is as follows:
>
```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}
  :dependencies [[org.clojure/clojure "1.10.1"]]
  :repl-options {:init-ns todo-list.core})
```

## Licence change

All code by Practicalli is under the Creative Commons Attribution Share-alike.

As well as changing the `project.clj` file `:licence` declaration, the `LICENCE` file created by the Leiningen template has been deleted as it refers to another licence.
