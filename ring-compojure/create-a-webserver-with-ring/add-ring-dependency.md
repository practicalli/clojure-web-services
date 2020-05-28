# Add Ring Dependency
Add the ring library as a depencency of the todo-list project.

> #### Note::Add ring dependency
> Edit the `project.clj` file and add **[ring "1.8.0"]** to the `:dependencies` section, after the Clojure library dependency.
>
```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"
  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}
  :dependencies [[org.clojure/clojure "1.10.1"]
                 [ring "1.8.0"]]
  :repl-options {:init-ns todo-list.core})
```

---

> ####Hint::Dependencies with Leiningen
Read the [dependencies secion of the Leiningen documentation](https://github.com/technomancy/leiningen/blob/stable/doc/TUTORIAL.md#dependencies) to learn more about adding libraries.

## Looking up Libraries & current versions
  Libraries created by the Clojure community can be found on [Clojars.org](https://clojars.org), an online repository similar to Maven Central.

  Use the Clojars.org website to search for the [latest version of Ring](https://clojars.org/search?q=ring).

![Clojars.org ring dependency](/images/clojure-webdev-clojars-ring.png)

  The dependency notation for Leiningen is documented for each library, making it easy to add the library to your project.
