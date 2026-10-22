# Server-side API's

Creating a well-defined API is an excellent way to make a service accessible to the wider world.

Using the OpenAPI specification, APIs provide interactive documentation, making the API more accessible and easier to test.

The [:fontawesome-solid-book-open: ring specification](/clojure-web-services/reference/ring/) abstracts HTTP requests & responses, automatically converting to and from a Clojure hash-map.

Clojure routing libraries typically take either use a data configuration (e.g. [Reitit](#reitit)) or provide a Domain Specific Language (DSL) for defining routes ([Compojure](#compojure)).

??? HINT "Practicalli recommends Reitit"
    There are many excellent routing libraries available for Clojure, however reitit is very well documented and takes a data centric approach.

    Practicalli has found reitit easy to work with on new project and for migrate existing project to.


## Reitit

Reitit is a data defined routing library which can be used with the Ring specification and middleware.

Defining route configuration as data simplifies validation, with errors returned containing clojure.spec information (or Malli).

Routing is bi-directional and the configuration is pre-compiled to be highly efficient at runtime.

- supports ring routing and middleware support (reitit-ring library)
- request and response validation (clojure.spec or Malli library)
- automatic data coercion (customisable)
- swagger-ui (OpenAPI) documentation with custom templates

[:fontawesome-solid-book-open: Reitit in more details](reitit/){.md-button}


## Compojure

The [Compojure library](https://github.com/weavejester/compojure/wiki) provides the `defroutes` macro and HTTP methods (GET, POST, etc) as a DSL for defining routes.

### compojure-api

Compojure API library and template provide a quick way to create an API, by extending Compojure features.

![Compojure API overview](/images/clojure-ring-compojure-api-overview.png)

[`compojure-api` library](https://github.com/metosin/compojure-api/wiki){target=_blank .md-button}


[:fontawesome-brands-github: Compojure API documentation](https://github.com/metosin/compojure-api/wiki){target=_blank .md-button}



## Open API

A standard way to define and API and create an interactive UI to aid in use and testing.

[OpenAPI Initiative](https://www.openapis.org/){target=_blank} is an open standards body that steers the [OpenAPI Specification (OAS)](https://www.openapis.org/what-is-openapi){target=_blank}, which provides a REST API description language as a standard way to describe and consume APIs.

OpenAPI was formally known as Swagger. [Swagger](https://swagger.io/){target=_blank} and [Swagger UI](https://swagger.io/open-source/swagger-ui/){target=_blank} are tools that support the implementation the OpenAPI specification.

An OpenAPI Schema can be defined in an `openapi.json` or `openapi.yaml` file.

Version 3.2 is the latest release of OpenAPI specification (February 2025)

OpenAPI UI uses the API code and meta data to produce a customisable web interface for an API, increasing discoverability and enabling testing of that API.

![Swagger UI](https://www.anthony-galea.com/images/2016-04-28-swagger.png)

[Swagger](https://swagger.io/){target=_blank .md-button}
[Swagger UI](https://swagger.io/open-source/swagger-ui/){target=_blank .md-button}

[Wikipedia: OpenAPI Specification (OAS)](https://en.wikipedia.org/wiki/OpenAPI_Specification){target=_blank .md-button}

## References

* [Getting started with Compojure API](https://www.anthony-galea.com/blog/post/getting-started-with-compojure-api/)
* [`ring-swagger`](https://github.com/metosin/ring-swagger)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part1](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-1/)
* [RESTful CRUD APIs Using Compojure-API and Toucan - part2](https://www.demystifyfp.com/clojure/blog/restful-crud-apis-using-compojure-api-and-toucan-part-2/)

### Tools

[OpenGUI - generate UI from OpenAPI specification](https://opengui.app/){target=_blank}
[OS Forge - write YAML with SwaggerUI preview](https://oasforge.dev/){target=_blank}

## Alternatives

* [Yada introduction - JUXT.pro](https://juxt.pro/blog/posts/yada-1.html){target=_blank}
* [Yada manual](https://juxt.pro/yada/manual/index.html){target=_blank}

??? INFO "Prismatic schema - lightweight type system for API definition"
    A library for declarative data description and validation. Schema validation uses Objects, a lightweight type system, to define the shape of any data that the API will respond with as well as any data that is sent along with a request.
