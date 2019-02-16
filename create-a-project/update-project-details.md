# Update project details

Although its optional for this exercise, its very useful to add details about the project so others know what its about (and for yourself when you havent worked on it for a while).

Update to `org.clojure/clojure "1.10.0"` to use the latest version of Clojure.  Version 1.9.0 originally added by Leiningen is okay too.

Change the `project.clj` file `:licence` declaration if you wish to use another licence and delete the `LICENCE` file.  Leiningen creates projects using the Eclipse Public License, as used for the Clojure language, although this may not be right for you.

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"

  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"

  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}

  :dependencies [[org.clojure/clojure "1.10.0"]])
```

## Update the project readme

By adding a description of the project in the `README.md` file is a simple way for everyone to understand what the project is about.  It is also common to provide details on how to run the project or use it as a library.
