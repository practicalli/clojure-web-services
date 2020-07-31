# H2 Relational Database
H2 is a Java SQL database that is typically used in-memory for a self-contained development environment for applications requiring a relational database.  Data is persisted to `mv.db` files.

H2 can be required as a library in the project dependencies, avoiding the need for external installation.

## H2 database  main features
* Very fast, open source, JDBC API
* Embedded and server modes; in-memory databases
* Browser based Console application
* Small footprint: around 2 MB jar file size

## Using h2 in the REPL


## Including H2 in Clojure projects

`next.jdbc` is highly recommended library for SQL queries in Clojure

{% tabs deps="deps.edn projects", lein="Leiningnen projects" %}

{% content "deps" %}
deps.edn

```clojure
{:deps {org.clojure/clojure {:mvn/version "1.10.1"}
seancorfield/next.jdbc {:mvn/version "1.1.569"}
com.h2database/h2 {:mvn/version "1.4.200"}}}
```

{% content "lein" %}

TODO:

{% endtabs %}
