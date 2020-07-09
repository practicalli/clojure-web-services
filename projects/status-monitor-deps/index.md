# Status Monitor project with Clojure tools
A status monitor dashboard to show operational status of a range of services.

A server-side web application using
- ring and compojure for webapp request management
- bulma CSS library for styling
- hiccup for writing html in Clojure syntax
- SVG graphics for status graphics
- clojure.spec for validating functions and svg definitions in Clojure


## Creating a project
Use `clj-new` to create the project (alias defined in practicalli/clojure-deps-edn)

```shell
clojure -A:new app practicalli/status-monitor
```

> #### Hint::Use practicalli/clojure-deps-edn to add common tools
> fork and clone the [practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) GitHub repository to instantly have access to dozens of tools for Clojure software development
