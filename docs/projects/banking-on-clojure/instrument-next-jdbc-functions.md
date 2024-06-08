# clojure.spec: Instrument next.jdbc functions

![Clojure specifications for next.jdbc](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/spec/clojure-spec-blueprints-industrial.png)

[Clojure specifications](http://practicalli.github.io/clojure/clojure-spec/) are available for all `next.jdbc` functions contained in namespaces `next.jdbc`, `next.jdbc.connection`, `next.jdbc.prepare`, and `next.jdbc.sql`.

Instrumenting the functions with their specifications will check the arguments passed to a function conform to the appropriate specification.  If the arguments conform, the next.jdbc function will evaluate with those arguments.  If the arguments do not conform, then an error is returned.

Instrumenting specifications provided additional details when errors occur, helping diagnose the issue quickly.

## Require the next.jdbc specifications
Require the `next.jdbc.specs` namespace in the project, typically in the namespace where `next.jdbc` is also required.

```clojure
(ns practicalli.database-access
  (:require
    [next.jdbc :as jdbc]
    [next.jdbc.specs :as jdbc-spec]))
```

In a Rich Comment block, call the `instrument` function from `next.jdbc.specs` namespace.  This will instrument the specifications for all functions across all the next.jdbc namespaces.

```clojure
(comment

  (jdbc-spec/instrument)
)
```
Instrumented functions are typically used during development, not in staging or production.  Only calling `instrument` manually from a rich comment block ensures the developer controls when functions are instrumented.


## Runtime checking
With instrumentation enabled, any calls to `next.jdbc` functions will have the arguments checked to ensure they conform to the specification.

For example, the instrumented `execute!` function will generate an error if passed an SQL statement as a string, rather than a vector containing a string.

```clojure
(jdbc/execute! data-source "SELECT * FROM account_holders")

Call to #'next.jdbc/execute! did not conform to spec.
```

<!-- TODO: add example and full output -->

The `:problems` section of the instrumented function error includes the `:path [:sql :sql-params]` and `:pred vector?` for the `:val "SELECT * FROM account_holders"`.

Without the instrumented specification,  assistance, the less helpful error message `ClassCastException` is the only assistance when debugging the issue.


Example from Banking on Clojure
![Clojure WebApps - next.jdbc specs error - Banking on Clojure](/images/clojure-webapps-next-jdbc-spec-error-vector.png)


## Turning off instrumentation for next.jdbc
`unstrument` function removes the instrumentation from the functions.  Typically this is called from a rich comment block too, as its not common to run instrumented functions outside of the development environment.

```clojure
(comment

  (jdbc-spec/instrument)
  (jdbc-spec/unstrument)

)
```
