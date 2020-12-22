# Status Monitor project with Clojure tools
A status monitor dashboard to show operational status of a range of services.

> #### INFO::Project actively being developed as part of Practicalli Study Group

A server-side web application using
- ring and compojure for webapp request management
- bulma CSS library for styling
- hiccup for writing html in Clojure syntax
- SVG graphics for status graphics
- clojure.spec for validating functions and svg definitions in Clojure


## Creating a project
Use `clj-new` to create the project (alias defined in practicalli/clojure-deps-edn)

```shell
clojure -M:project/new app practicalli/status-monitor-service
```

> #### Hint::Use practicalli/clojure-deps-edn to add common tools
> fork and clone the [practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) GitHub repository to instantly have access to dozens of tools for Clojure software development


## Tweaking the project
Some minor tweaks are made to the project before starting the application development

- describe the project and how it can be used in the README
- delete the LICENSE file and use a Creative Commons in the README
- format the deps.edn file for readability


## Code repository
The code for this section can be found on [practicalli/status-monitor-service](https://github.com/practicalli/status-monitor-service)
