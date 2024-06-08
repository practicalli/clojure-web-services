# Status Monitor project with Clojure tools
A status monitor dashboard to show operational status of a range of services.

A server-side web application using
- ring and compojure for webapp request management
- bulma CSS library for styling
- hiccup for writing html in Clojure syntax
- SVG graphics for status graphics
- clojure.spec for validating functions and svg definitions in Clojure


## Creating a project

=== "deps-new"
    Create a project using the app template and called practicalli/status-monitor.  The `:project/create` alias from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/) uses the deps-new project to create Clojure projects
    ```bash
    clojure -T:project/create :template app :name practicalli/status-monitor
    ```
    Some minor tweaks are made to the project before starting the application development

    - describe the project and how it can be used in the README
    - delete the LICENSE file and use a Creative Commons in the README
    - format the deps.edn file for readability


=== "Manual"
    Create a project in a directory called status-monitor, with a `deps.end` file in the root of that directory
    ```clojure title="deps.edn"
    {:paths ["src"]
     :deps {org.clojure/clojure {:mvn/version "1.11.3"}}}
    ```
    Create a `src/practicalli/status_monitor.clj` file
    ```clojure title="src/practicalli/status_monitor.clj"
    (ns practicalli.status-monitor)
    ```
    Create a `test/practicalli/status_monitor_test.clj` file
    ```clojure title="src/practicalli/status_monitor.clj"
    (ns practicalli.status-monitor-test
      (:require [clojure.test :refer [deftest is testing]]))
    ```


!!! EXAMPLE "practicalli/status-monitor"
    The code for this project can be found at [practicalli/status-monitor](https://github.com/practicalli/status-monitor)
