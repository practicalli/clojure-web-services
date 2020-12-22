# Cyclic Load Dependency
   A cyclic load depenency is where one namespace requires one or more other namespaces that then require the original namespace, forming a loop when resolve all the required namespaces.  When there are cyclic namespace dependencies a warning is returned when evaluating any of the namespaces involved.

A good way to spot cyclic load dependencies it to regularly run a test runner on the code, or even set up a test runner to watch for changes to the file system which then triggers an automatic test run.  For example, `kaocha --watch`.

## Tips on avoiding  cyclic load dependencies

* Add comment sections describing the purpose of the different parts of code, creating logical separation of code.  Refactor of namespaces is far easier to see and helps ensure related code is kept together.

* Ensure test and specification code is in its own namespace.  Keeping the right level of abstraction in tests and clojure spec test.check can help avoid issues.

* Use `require` to add dependent namespaces, preferably using a meaningful `:as` alias or using `:refer` for only the function names used. `(:require ,,, :refer :all)` or `(use ,,)` expressions can pull in too many other namespaces and cause issues

* A cyclic load dependency error message is a good point to review and refactor the application design.

* Where two namespaces are interdependent on each other, factor out shared code into a third namespace required by each of the other two.  This breaks the dependency between the two original namespaces.


## Example - Banking on Clojure

The `practicalli.request-handler` namespace contains functions that need to access data in the database, so the `practicalli.database-access` namespace is required.

```clojure
(ns practicalli.request-handler
  (:require
   ;; Web Application
   [ring.util.response :refer [response]]
   [hiccup.core :refer [html]]
   [hiccup.page :refer [html5 include-js include-css]]
   [hiccup.element :refer [link-to]]

   ;; Data access
   [practicalli.database-access :as data-access]))
```

The `practicalli.database-access` namespace required the `practicalli.specifications-banking` namespace to use the specifications for generating data

```clojure
(ns practicalli.database-access
  (:require [next.jdbc :as jdbc]
            [next.jdbc.sql :as jdbc-sql]
            [next.jdbc.specs :as jdbc-spec]

            [practicalli.specifications-banking]))
```

In the `practicalli.specifications-banking` namespace, a functional specification had been defined for the `register-account-holder` function, which required the `practicalli.request-handler` to be required.  Even though the specifications testing had logically moved to the database-access namespace, this functional specification remained.

```clojure
(ns practicalli.specifications-banking
  (:require
   ;; Clojure Specifications
   [clojure.spec.alpha :as spec]
   [clojure.spec.gen.alpha :as spec-gen]
   [clojure.spec.test.alpha :as spec-test]
   [practicalli.specifications]

   ;; Helper namespaces
   [clojure.string]

   [practicalli.request-handler :as SUT]))
```


This set of require expressions lead to a cyclic load dependency error.

`->` indicate that a namespace requires the namespace it is pointing too.

![cyclic load dependency - banking on clojure](/images/clojure-webapps-error-cyclic-load-depencency.png)


Removing the require of `practicalli.request-handler` from the `practicalli.specifications-banking` namespace breaks the cyclic dependency.


;; Testing the database on CI

Need to create the tables before the tests can run.
- update the schema so the create tables can run without failure, check if table exist and if not create it.
