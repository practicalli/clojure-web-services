# Update the project

Specify how Leiningen builds the project in more detail and tell Heroku how to run the application.


## Configure the Leiningen Build

Update the Clojure project file with a minimum version number for Leiningen and a name for the jar file that Leiningen will build

Edit the `project.clj` file and add the following lines, usually after the dependencies declarations

```clojure
:min-lein-version "2.0.0"
:uberjar-name "todo-list.jar"
```

The update project file should look as follows

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A simple webapp using Ring"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [ring "1.4.0-beta2"]
                 [compojure "1.3.4"]]
  :main todo-list.core
  :min-lein-version "2.0.0"
  :uberjar-name "todo-list.jar"
  :profiles {:dev
              {:main todo-list.core/-dev-main}})
```
