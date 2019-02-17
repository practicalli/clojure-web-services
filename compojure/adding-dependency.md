# Adding the Compojure dependency

> ####Note:: Edit your project configuration `project.clj` and add compojure as a dependency.

The current version of Compojure is: **[compojure "1.3.4"]**

> ####Hint:: You can look up the version of [Compojure on Clojars.org](https://clojars.org/compojure) or any other Clojure library.  [Clojars.org](https://clojars.org/) is like Maven Central for Clojure.

The `project.clj` file should look as follows:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A simple webapp in Clojure"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [ring "1.4.0-beta2"]
                 [compojure "1.3.4"]]
  :main todo-list.core
  :profiles {:dev
             {:main todo-list.core/-dev-main}})
```

  You will need to kill `Ctrl-c` and restart the webserver as we are adding a library to the project.

```bash
lein run 8000
```
