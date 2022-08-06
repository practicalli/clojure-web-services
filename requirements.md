## Requirements

Practicalli provides an [install guide for Clojure](https://practical.li/clojure/clojure-cli/install/) and a [wide selection of Clojure aware editors](https://practical.li/clojure/clojure-editors/)

Recommended development tools for this guide are:

* [Java OpenJDK version 17](https://practical.li/clojure/clojure-cli/install/java.html) (version 11 onward should work)
* [Clojure CLI](https://practical.li/clojure/clojure-cli/install/clojure-cli.html) and [practicalli/clojure-deps-edn aliases](https://practical.li/clojure/clojure-cli/install/community-tools.html)
* A [Clojure aware editor](https://practical.li/clojure/clojure-editors/)

Code examples can be used with any Clojure build tool, although this guide focuses on using Clojure CLI tools. Some examples use [Leiningen](http://leiningen.org/) and will be updated to Clojure CLI soon.


## Additional Development tools

To complete all the steps in this guide, especially around deployment tasks, additional development tools and services are required.

| Development Tools                                                                                           | Version | Test (command line) |
|:------------------------------------------------------------------------------------------------------------|:--------|:--------------------|
| [A Git client](http://git-scm.com/)                                                                         | latest  | `git --version`     |
| [CircleCI account](http://circleci.com) for continuous integration                                          |         |                     |
| [Heroku account](http://heroku.com) and [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)      | latest  | `heroku --version`  |
| [Heroku Postgres](https://www.heroku.com/postgres) or local [Postgres database](https://www.postgresql.org/) | latest  |                     |

[CircleCI](http://circleci.com) is a developer focused service for Continuous Integration, providing obs that package up common workflows such as deploying to Heroku.

[Heroku](http://heroku.com) is used for uncomplicated deploying of web applications in the cloud as well as provisioning services such as Postgres database on demand.  You can skip Heroku if you only wish to run your applications locally or have some other service to deploy them.  Install [Postgres database](https://www.postgresql.org/) locally if not using a service such as Heroku.

> #### Hint::Why not docker?
> Practicalli tends toward the simplest and developer oriented architectural decisions, making deployment from source a trivial process with adherence to the [12 Factor design](https://12factor.net/) approach.
>
> Docker does add a layer of indirection and more configuration is required to deploy Clojure Services in this manor.  Practicalli does welcome Docker (and Docker compose, kubernetes, GitPod, etc) contributions to this guide, allowing Practicalli more time to focus on Clojure specific content.  Practicalli may cover these aspects if enough interested is shown.


## PostgreSQL Alternatives

Practicalli is considering other persistent storage approaches for this guide and any contributions in this regard is much appreciated

* [Crux](https://opencrux.com/) - an open source document database with bitemporal graph queries
* [Datomic](https://www.datomic.com/) - a transactional database with a flexible data model, elastic scaling, and rich queries.
* [Amazon Aurora](https://aws.amazon.com/rds/aurora/) - MySQL and PostgreSQL compatible cloud native relational database
* [Amazon DynamoDB](https://aws.amazon.com/dynamodb/) with Clojure [Faraday](https://github.com/Taoensso/faraday) library - for persisting JSON like data structures


## Leiningen approach (to be archived)

Install [Leiningen](http://leiningen.org/) for the [Leiningen Todo App project](projects/leiningen/todo-app/) and test the Leinigen install by running the command `lein version` in a terminal application.
