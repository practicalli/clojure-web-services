# Application Server Logging

> #### TODO::work in progress, sorry

* What to log in which environments
* Logging levels
* Logging as object rather than text
* [mulog](https://github.com/BrunoBonacci/mulog)

![Clojure WebApps application server startup via the REPL](/images/clojure-webapps-app-server-start-via-repl.png)


## Logging to Elastic Search / Kibana
*
* [Elastisch, a Clojure client for Elasticsearch](http://clojureelasticsearch.info/) and [GitHub repository](https://github.com/clojurewerkz/elastisch)
* [Elasticsearch and Clojure: Getting Started](https://miguelmalvarez.com/2016/04/27/elasticsearch-and-clojure-getting-started/) - the practical academic
* [Spandex - Elasticsearch new low level rest-client wrapper](https://github.com/mpenet/spandex)



## Problematic Practices
Logging to the REPL - sending lots of logs to the REPL makes the REPL much harder to use directly

Logging strings - logs entries are typically objects and far more searchable and discoverable that strings, so send objects to the logging service
