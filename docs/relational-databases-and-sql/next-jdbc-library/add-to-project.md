# Add next.jdbc to a project

Create a new Clojure project using clj-new tool (see [Clojure install for details](http://practicalli.github.io/clojure/clojure-tools/install/install-clojure.html))

```bash
clojure -T:project/new :template app :name practicalli/simple-database
```


## Main library dependency

Edit the `deps.edn` file in the root of the project directory.

In the `:deps` hash-map, add next.jdbc libraries as a dependency

```clojure
{:deps {org.clojure/clojure    {:mvn/version "1.10.1"}
        org.seancorfield/next.jdbc {:mvn/version "1.1.569"}}}
```

An alias should be used to include the H2 database library as a development dependency, to avoid including it in the packaged project.

{% tabs practicalli="practicalli/clojure-deps-edn", manual="Manually add Alias" %}

{% content "practicalli" %}

[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) provides user level aliases that can be used with any project

`:database/h2` adds the [library dependency for H2 database](https://mvnrepository.com/artifact/com.h2database/h2)


{% content "manual" %}

Edit the project `deps.edn` file in the root of the project (or add an alias to the user level deps.edn to use with any project).

Include an `:extra-deps` section for the [H2 library](https://mvnrepository.com/artifact/com.h2database/h2)

```clojure
{:deps {org.clojure/clojure    {:mvn/version "1.10.1"}
        org.seancorfield/next.jdbc {:mvn/version "1.1.569"}}}

 :aliases
 {:database/h2
  {:extra-deps {com.h2database/h2 {:mvn/version "2.1.210"}}}}
```

{% endtabs %}


## Starting a REPL for development

Include the `:database/h2` alias when starting a REPL

```bash
clojure -M:database/h2:repl/rebel
```


## Staging and Production dependencies

Assuming PostgreSQL is used as the staging and production database, the postgres library should be added to the main dependencies of the project.

In the `:deps` hash-map, add the [PostgreSQL JDBC driver library](https://mvnrepository.com/artifact/org.postgresql/postgresql) as dependencies along-side next.jdbc.

```clojure
{:deps
  {org.clojure/clojure {:mvn/version "1.10.1"}

  ;; Database
  org.seancorfield/next.jdbc    {:mvn/version "1.1.582"}
  org.postgresql/postgresql {:mvn/version "42.2.16"}}}
```


> #### Hint::Check for latest library versions
> Check clojars.org for [latest version org.seancorfield/next.jdbc](https://clojars.org/seancorfield/next.jdbc) and Maven Central for [latest version of H2 database](https://mvnrepository.com/artifact/com.h2database/h2)
>
> [jdbc.postgres.org](https://jdbc.postgresql.org/) shows the latest release, or look at the [Postgresql page on Maven Central](https://mvnrepository.com/artifact/org.postgresql/postgresql)
