## Requirements

Java 11, Clojure CLI tools and a Clojure aware editor are the minimal requirements for this guide.

Code examples can be used with any Clojure build tool (eg. Leiningen, Boot), although this guide focuses on using Clojure CLI tools.

{% tabs cli="Cloure CLI", lein="Leiningnen" %}

{% content "cli" %}

## Clojure CLI and tools.deps approach

Follow the [Clojure tools install guide](http://practical.li/clojure/clojure-cli/install/) from Practicalli Clojure, ideally installing a [Clojure aware editor](https://practical.li/clojure/clojure-editors/) too.


{% content "lein" %}

## Leiningen approach

Install [Leiningen](http://leiningen.org/) for the [Leiningen Todo App project](projects/leiningen/todo-app/) and test the Leinigen install by running the command `lein version` in a terminal application.


{% endtabs %}



## Additional Development tools

To complete all the projects in this guide, you will also need additional development tools

| Development Tools                                                                                           | Version | Test (command line) |
|:------------------------------------------------------------------------------------------------------------|:--------|:--------------------|
| [A Git client](http://git-scm.com/)                                                                         | latest  | `git`               |
| [CircleCI account](http://circleci.com) for continuous integration                                          |         |                     |
| [Heroku account](http://heroku.com) and [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli)      | latest  | `heroku --version`  |
| [Heroku Postgres](https://www.heroku.com/postgres) or local [Postres database](https://www.postgresql.org/) | latest  |                     |

[Heroku](http://heroku.com) is used for uncomplicated deploying of web applications in the cloud as well as provisioning services such as Postgres database on demand.  You can skip Heroku if you only wish to run your applications locally or have some other service to deploy them.  Install [Postres database](https://www.postgresql.org/) locally if not using a service such as Heroku.

> #### Hint::Why not docker?
> Practicalli tends toward the simplest and developer oriented architectural decisions, making deployment from source a trivial process with adherence to the [12 Factor design](https://12factor.net/) approach.
>
> Docker does add a layer of indirection and more configuration is required to deploy Clojure Services in this manor.  Practicalli does welcome Docker (and Docker compose, kubernetes, GitPod, etc) contributions to this guide, allowing Practicalli more time to focus on Clojure specific content.  Practicalli may cover these aspects if enough interested is shown.


## PostgreSQL Alternatives

Practicalli is considering other persistent storage approaches for this guide and any contributions in this regard is much appreciated

* [JUXT XTDB](https://xtdb.com/) - an open source document database with bitemporal graph queries
* [Datomic](https://www.datomic.com/) - a transactional database with a flexible data model, elastic scaling, and rich queries.
* [Amazon Aurora](https://aws.amazon.com/rds/aurora/) - MySQL and PostgreSQL compatible cloud native relational database
* [Amazon DynamoDB](https://aws.amazon.com/dynamodb/) with Clojure [Faraday](https://github.com/Taoensso/faraday) library
