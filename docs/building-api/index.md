# Server-side API's

APIs are an excellent way to make a service accessible to the wider world.

Server-side apis in Clojure can be self-documenting (OpenAPI), highly efficient and a joy to develop.

The [:fontawesome-solid-book-open: ring specification](/clojure-web-services/reference/ring/) abstracts HTTP requests & responses, automatically converting to and from Clojure hash-maps which are far simpler and effecitive to work with.

Clojure routing libraries typically take either use a data configuration or provide a Domain Specific Language (DSL) for defining routes.

!!! HINT "Practicalli recommends Reitit"
    There are many excellent routing libraries available for Clojure, however reitit is very well documented and takes a data centric approach.

    Practicalli has found reitit very easy to work with on new project and to migrate existing project.

## Reitit

Reitit is a data defined routing library which can be used with the Ring specification and middleware.  

Route configuration is pre-compiled, so if highly efficient.  Routing is also bi-directional.  Defining route configuration as data simplifies validation, with errors returned containing clojure.spec information.

- define routes as data (validated with clojure.spec)
- ring support
- middleware support
- data coercion
- validation (clojure.spec or Malli)
- swagger (openapi) documentation with custom templates

[:fontawesome-solid-book-open: Reitit](reitit/){.md-button}


## Compojure

[`compojure` library](https://github.com/weavejester/compojure/wiki) provides the `defroutes` macro and HTTP methods (GET, POST, etc) as a DSL for defining routes.

### compojure-api

Compojure API library and template provide a quick way to create an API, by extending Compojure features.

![Compojure API overview](/images/clojure-ring-compojure-api-overview.png)

[`compojure-api` library](https://github.com/metosin/compojure-api/wiki){target=_blank .md-button}


[:fontawesome-brands-github: Compojure API documentation](https://github.com/metosin/compojure-api/wiki){target=_blank .md-button} 

## Prismatic schema

Schema validation defines the shape of any data that the API will respond with as well as any data that is sent along with a request.

## Self-documenting with Swagger

This template contains Swagger that documents the API's you are creating and ring-swagger constructs the documentation as you create your code.

![Swagger UI](https://www.anthony-galea.com/images/2016-04-28-swagger.png)


## References

* [Getting started with Compojure API](https://www.anthony-galea.com/blog/post/getting-started-with-compojure-api/)
* [`ring-swagger`](https://github.com/metosin/ring-swagger)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part1](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-1/)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part2](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-2/)


## Alternatives

* [Yada introduction - JUXT.pro](https://juxt.pro/blog/posts/yada-1.html)
* [Yada manual](https://juxt.pro/yada/manual/index.html)
