## Requirements

> #### Hint:: 2020 refresh
> This guide will be updated use Clojure CLI tools and tools.deps.  See the [Clojure web server from scratch with deps.edn](https://practicalli.github.io/blog/posts/clojure-web-server-cli-tools-deps-edn/) article and [Webapp with deps.edn and httpkit video](https://www.youtube.com/watch?v=SPSn02RxpxM&list=PLpr9V-R8ZxiDjyU7cQYWOEFBDR1t7t0wv&index=52) for examples of what is to come.


## Clojure CLI and tools.deps approach
Follow the [Clojure tools install guide](http://practicalli.github.io/clojure/clojure-tools/install/) from Practicalli Clojure, ideally installing a [Clojure aware editor](https://practicalli.github.io/clojure/clojure-editors/) too.

To complete all the projects in this guide, you will also need additional development tools

| Development Tool                                                                                            | Version | Test (command line) |
| :--                                                                                                         | :--     | :--                 |
| [A Git client](http://git-scm.com/)                                                                         | latest  | `git`               |
| [CircleCI account](http://circleci.com) for continuous integration                                          |         |                     |
| [Heroku account](http://heroku.com) and [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)      | latest  | `heroku --version`  |
| [Heroku Postgres](https://www.heroku.com/postgres) or local [Postres database](https://www.postgresql.org/) | latest  |                     |

[Heroku](http://heroku.com) is used for uncomplicated deploying of web applications in the cloud as well as provisioning services such as Postgres database on demand.  You can skip Heroku if you only wish to run your applications locally or have some other service to deploy them.  Install [Postres database](https://www.postgresql.org/) locally if not using a service such as Heroku.

> #### Todo::Investigate other Data services
* [Datomic](https://www.datomic.com/) - a transactional database with a flexible data model, elastic scaling, and rich queries.
* [Crux](https://opencrux.com/) - an open source document database with bitemporal graph queries
* [Amazon Aurora](https://aws.amazon.com/rds/aurora/) - MySQL and PostgreSQL compatible cloud native relational database


## Leiningen approach (to be archived)
Install [Leiningen](http://leiningen.org/) for the [Leiningen Todo App project](projects/leiningen/todo-app/) and test the Leinigen install by running the command `lein version` in a terminal application.
