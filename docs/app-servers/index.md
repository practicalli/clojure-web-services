# Application servers

Application servers provide a common platform services to support server-side running of JVM applications (hence the term application server).

These servers are often referred to more generically as web servers as they mostly work over http / https.

Clojure uses embedded servers to support REPL Driven Development, so both new function definitions and server restarts can be managed within the context of a running REPL (avoiding the need to restart the REPL).

![Clojure WebApps simplified stack](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-web-services/clojure-web-apps-stack.png)


# Application components

* Routing
* Requests
* Responses
* Middleware


## Practicalli defacto library choices

Practicalli defacto choices for building web services:


| Library        | Purpose                                                                                       |
|:---------------|-----------------------------------------------------------------------------------------------|
| ring/ring      | Provides Jetty and Ring - managing requests and responses in Clojure using hash-maps          |
| metosin/reitit | Routing of request and responses, support for ring handlers and middleware (and interceptors) |


## Example Projects

| Project            | Description                                                                                                                                                                                   |
|:-------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Status Monitor     | Clojure CLI project using Httpkit, Compojure for routing, Hiccup and SVG graphics.  Deployed via CircleCI on Heroku                                                                           |
| Banking On Clojure | Clojure CLI project using httpkit, Ring utilities, Compojure for routing.  relational data store using next.jdbc, HoneySQL, clojure.spec & postgresql.  Generative testing using clojure.spec |
| ToDo app           | Leiningen project using Ring (Jetty), Compojure for routing and Hiccup for HTML generation                                                                                                    |
