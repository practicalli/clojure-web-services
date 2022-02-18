# Server-side API's

We can build an Application Programming Interface (API) in Clojure by building on the techniques we have learnt as we built our server-side web applications (ring, compojure, etc.).

## compojure-api

We are going to use the [`compojure-api` library](https://github.com/metosin/compojure-api/wiki) and its Leiningen template to quickly build our API.

![Compojure API overview](/images/clojure-ring-compojure-api-overview.png)

[Compojure API documentation](https://github.com/metosin/compojure-api/wiki)

## Prismatic schema

Schema validation defines the shape of any data that the API will respond with as well as any data that is sent along with a request.

## Self-documenting with Swagger

This template contains Swagger that documents the API's you are creating and ring-swagger constructs the documentation as you create your code.

![Swagger UI](https://www.anthony-galea.com/images/2016-04-28-swagger.png)


## lein-ring Reloaded workflow

`lein-ring` is a plugin for Leiningen that will reload code changes into a running web application server (i.e. Jetty).


## References

* [Getting started with Compojure API](https://www.anthony-galea.com/blog/post/getting-started-with-compojure-api/)
* [`ring-swagger`](https://github.com/metosin/ring-swagger)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part1](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-1/)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part2](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-2/)


## Alternatives

* [Yada introduction - JUXT.pro](https://juxt.pro/blog/posts/yada-1.html)
* [Yada manual](https://juxt.pro/yada/manual/index.html)
