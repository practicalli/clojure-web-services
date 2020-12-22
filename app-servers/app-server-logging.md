# Application Server Logging

> #### TODO::work in progress, sorry

* What to log in which environments
* Logging levels
* Logging as object rather than text
* [mulog](https://github.com/BrunoBonacci/mulog)



## Simplistic logging
`println` function sends information to the standard out and so is a very simple mechanism to create logs from specific parts of the application. This should be used sparingly and is no substitute for a specific logging framework.

`printlin` can be useful in the REPL the standard out message as well as the evaluation result (`nil`) are shown.  `printlin` can provide additional feeback for non-terminating processes that run in the REPL, such as an application server.

![Clojure WebApps application server startup via the REPL](/images/clojure-webapps-app-server-start-via-repl.png)

## Logging to Elastic Search / Kibana
Log messages as objects, rather than text strings, provides greater sophistication by search tools as the messages have a structure.

* [Elastisch, a Clojure client for Elasticsearch](http://clojureelasticsearch.info/) and [GitHub repository](https://github.com/clojurewerkz/elastisch)
* [Elasticsearch and Clojure: Getting Started](https://miguelmalvarez.com/2016/04/27/elasticsearch-and-clojure-getting-started/) - the practical academic
* [Spandex - Elasticsearch new low level rest-client wrapper](https://github.com/mpenet/spandex)



## Problematic Practices
Logging to the REPL - sending lots of logs to the REPL makes the REPL much harder to use directly

Logging strings - logs entries are typically objects and far more searchable and discoverable that strings, so send objects to the logging service
