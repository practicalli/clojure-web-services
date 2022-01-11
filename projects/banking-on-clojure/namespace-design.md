# Namespace design
A common approach to namespace design is to start with the main namespace for the application and migrate code to new namespaces as the codebase grows.


## Basic Principles
Basic principles of namespace design include

* focus namespaces on specific logical areas of the application
* avoid circular references between namespaces (i.e. two namespaces require each other)
* abstract code into namespaces to avoid the _ubernamespace_  (unless the application fits into ~100 lines of code)
* require the minimum number of namespaces
* use meaningful names for namespace aliases (if naming is hard, think again about splitting a namespace)
* use comment sections to separate code into logical groupings as its developed, highlighting potential sections of code that could split into its own namespace.


## Example web application namespace design
A general design that forms the basis of many web application projects

![Clojure WebApps - Banking on Clojure - namespace design](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-webapps/banking-on-clojure-design-namespace-segregation.png)


## Main application namespace
The main application namespace is typically used for code that manages the system, for example starting the application server, database, etc.  These services are often managed by component lifecycle services (mount, integrant, component).

Routing is usually a part of the  main application namespace, especially when there are a modest number of routes and a routing library such as compojure is used.  If routing becomes more extensive, then a separtate routing namespace is warranted.

## Handlers and custom middleware
Handlers define the business logic, data and presentation that turns requests into responses.  Start with a single namespace for handlers and segregate if the complexity grows sufficiently.

Middleware used directly with handlers is required in the handler namespace.

Middleware for the overall system may appear in the main application namespace, to wrap the application instance.

## UI pages and templates
Avoid adding complexity to the handlers by moving common web page / html generation code to its own namespace.

A single namespace provides a focused view for refactoring presentation code into templates and generators.

## Data queries
A namespace to design all the queries for a data source, which could be database, api's, file systems, etc.

SQL queries to relational database are defined here.

## Data sources
Details of data sources, from databases, api's or any sources of information to be processed.
