## Requirements

> #### Hint:: 2020 refresh
> This guide will be updated use Clojure CLI tools and tools.deps.  See the [Clojure web server from scratch with deps.edn](https://practicalli.github.io/blog/posts/clojure-web-server-cli-tools-deps-edn/) article and [Webapp with deps.edn and httpkit video](https://www.youtube.com/watch?v=SPSn02RxpxM&list=PLpr9V-R8ZxiDjyU7cQYWOEFBDR1t7t0wv&index=52) for examples of what is to come.
> The Leiningen approach will moved to the reference section.


## Clojure CLI and tools.deps approach

You will need the following in order to complete this workshop.  The [setup](/setup/) contains details on how to get your environment ready

| Development Tool                                                                                   | Version    | Test (command line) |
| :--                                                                                                | :--        | :--                 |
| [Java OpenJDK](https://adoptopenjdk.net/)                                                          | version 11 | `java -version`   |
| [Clojure CLI tools](https://clojure.org/guides/getting_started)                                    | latest     | `clojure`          |
| [Clojure editor](https://clojurebridgelondon.github.io/workshop/development-tools/install-guides/) |            |                     |

To complete all the projects in this guide, you will also need additional development tools

| Development Tool                                                                                            | Version | Test (command line) |
| :--                                                                                                         | :--     | :--                 |
| A Git client](http://git-scm.com/)                                                                          | latest  | `git`               |
| [Heroku account](http://heroku.com) and [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)      | latest  | `heroku --version`  |
| [Heroku Postgres](https://www.heroku.com/postgres) or local [Postres database](https://www.postgresql.org/) | latest  |                     |

Heroku is used for deploying webapps on the internet and using data services such as Postgres database.  You can skip Heroku if you only wish to run your applications locally or have some other service to deploy them.  For some projects you will need to install Posgtres database locally if not using a service such as Heroku.

> #### Todo::Investigate other Data services
> * [Amazon Aurora](https://aws.amazon.com/rds/aurora/) - MySQL and PostgreSQL compatible cloud native relational database


## Leiningen approach (to be archived)

You will need the following in order to complete this workshop.  The [setup](/setup/) contains details on how to get your environment ready

  * A working Java runtime environment (JRE) - test with `java -version` in a command line window
  * [Leiningen](http://leiningen.org/) - test with `lein version` in a command line window
  * A [Clojure aware editor with REPL](https://clojurebridgelondon.github.io/workshop/development-tools/install-guides/)
  * A [Git client](http://git-scm.com/) (optional)
  * [A free Heroku account](http://heroku.com) for running Postgres database (alternatively install Posgtres database on your laptop)
