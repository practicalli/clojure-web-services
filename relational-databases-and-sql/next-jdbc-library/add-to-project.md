# Add next.jdbc to a project
Create a new Clojure project using clj-new tool (see [Clojure install for details](http://practicalli.github.io/clojure/clojure-tools/install/install-clojure.html))

```shell
clojure -A:new app practicalli/simple-database
```

## Development library dependency
Edit the `deps.edn` file in the root of the project directory.

In the `:deps` hash-map, add next.jdbc and the H2 database libraries as dependencies

```clojure
{:deps {org.clojure/clojure    {:mvn/version "1.10.1"}
        seancorfield/next.jdbc {:mvn/version "1.1.569"}
        com.h2database/h2      {:mvn/version "1.4.200"}}}
```

As the H2 database is only used for development the library could be included via a specific alias.

In the project `deps.edn` a `:dev` alias could include an `:extra-deps` section for the H2 driver

```clojure
{:deps {org.clojure/clojure    {:mvn/version "1.10.1"}
        seancorfield/next.jdbc {:mvn/version "1.1.569"}}}

{:dev
  {:extra-deps {com.h2database/h2      {:mvn/version "1.4.200"}}}}
```

Or include a specifically named alias, e.g. `:database-h2`, in `~/.clojure/depsedn`.  This approach is useful when using the same database server with multiple projects.

```clojure
{:database-h2
  {:extra-deps {com.h2database/h2      {:mvn/version "1.4.200"}}}}
```


## Staging and Production dependencies
Assuming PostgreSQL is used as the staging and production database, the postgres library should be added to the main dependencies of the project.

In the `:deps` hash-map, add next.jdbc and the Postgresql database libraries as dependencies

```clojure
{:deps
  {org.clojure/clojure    {:mvn/version "1.10.1"}

  ;; Database
  seancorfield/next.jdbc    {:mvn/version "1.1.582"}
  org.postgresql/postgresql {:mvn/version "42.2.16"}}}
```

When developing the project, include the `:dev` or `:database-h2` when running the REPL to include the H2 database library

```shell
clojure -A:database-h2
```

> #### Hint::Check for latest library versions
> Check clojars.org for [latest version seancorfield/next.jdbc ](https://clojars.org/seancorfield/next.jdbc) and Maven Central for [latest version of H2 database](https://mvnrepository.com/artifact/com.h2database/h2)
>
> [jdbc.postgres.org](https://jdbc.postgresql.org/) publishes the releases of the database driver, so can be used to find the latest driver available.
