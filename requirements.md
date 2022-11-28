## Requirements

Practicalli provides an [install guide for Clojure](https://practical.li/clojure/clojure-cli/install/) and a [wide selection of Clojure aware editors](https://practical.li/clojure/clojure-editors/)

Recommended development tools for this guide are:

* [Java OpenJDK version 17](https://practical.li/clojure/clojure-cli/install/java.html) (version 11 onward should work)
* [Clojure CLI](https://practical.li/clojure/clojure-cli/install/clojure-cli.html) and [practicalli/clojure-deps-edn aliases](https://practical.li/clojure/clojure-cli/install/community-tools.html)
* A [Clojure aware editor](https://practical.li/clojure/clojure-editors/)

Code examples can be used with any Clojure build tool, although this guide focuses on using Clojure CLI tools. Some examples use [Leiningen](http://leiningen.org/) and will be updated to Clojure CLI soon.


## Additional Development tools

To complete all the steps in this guide, especially around deployment tasks, additional development tools and services are required.

| Development Tools                                                  | Version | Test (command line) |
|:-------------------------------------------------------------------|:--------|:--------------------|
| [Git client](http://git-scm.com/)                                  | latest  | `git --version`     |
| [Docker Desktop](https://www.docker.com/products/docker-desktop/)  | latest  | `docker --version`  |
| [Postgres database](https://www.postgresql.org/)                   | latest  |                     |


GitHub and GitHub actions will be predominantly used in this guide, although more use of CircleCI and GitLab will also be introduced. [CircleCI](http://circleci.com) is a developer focused service for Continuous Integration, developed with Clojure, providing obs that package up common workflows such as deploying to specific Cloud services.

| Continuous Integration Services       |
|:--------------------------------------|
| [GitHub Actions](http://circleci.com) |
| [GitLab CI](http://circleci.com)      |
| [CircleCI](http://circleci.com)       |


####WARNING::Heroku deployment deprecated
[Heroku](https://heroku.com) has been used to simplify deployment directly from source code using existing build packs.  Heroku now requires a commercial license for deployment so this content is to be deprecated.


## Persistence Alternatives

Practicalli is considering other persistent storage approaches for this guide and any contributions in this regard is much appreciated

* [Crux](https://opencrux.com/) - an open source document database with bitemporal graph queries
* [Datomic](https://www.datomic.com/) - a commercial transactional database with a flexible data model, elastic scaling, and rich queries.
* [Amazon Aurora](https://aws.amazon.com/rds/aurora/) - MySQL and PostgreSQL compatible cloud native relational database
* [Amazon DynamoDB](https://aws.amazon.com/dynamodb/) with Clojure [Faraday](https://github.com/Taoensso/faraday) library - for persisting JSON like data structures


## Leiningen approach (to be archived)

Install [Leiningen](http://leiningen.org/) for the [Leiningen Todo App project](projects/leiningen/todo-app/) and test the Leinigen install by running the command `lein version` in a terminal application.
