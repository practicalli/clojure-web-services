# Clojure Microservices

Clojure Microservices are an architectural design approach, with advantages and constraints.

Domain Driven Design (DDD) princilples are relevant to microservice design.

Effective testing is essential to avoid regressions and help ensure a consistent API across all services.  Changes should be additional rather than breaking where ever possible.

!!! QUOTE "Aspects of a Microservice"
    A microservice is a natural concequence of applying the single responsibility princilple at the architecture level

    A microservice typicaly has its own data store, persistence layer or connection to an event stream

    A microservice should to be loosley coupled to be effecitve to use and maintain


!!! WARNING "Avoid breaking API changes"
    The internal implementation of any microservice should be readily changed without breaking an established (shared) API.

    Once a microservice API is published to the system, only additional changes should be made to avoid breaking other services that depend on the microservice.

    Where breaking changes are the only remaining option, extensive communication is essential across the organisation.


??? WARNING "Page work in progress"

## Anatomy of a microservice

- Resource
- service layer
- domain model
- Repositories
- Persistent layer  |  Gateway


### Gateway

Abstract away the communication layer between micro-services


## DDD Bounded context

grouping your domain model in to self contained logical chunks

- small islands of concepts with relationships between them
- connection over rest or lightweight event bus
- can be deployed quickly (hours not days/weeks)
- understand the concequence of changes to a microservice


## Resilience

Microservices should not fail or cause others to fail

Comprehensive documentation should be maintained for each microservice, optionally generating and publishing the API documentation from the code of the service itself, e.g. swagger, backstage.io

Testing should focus on maintaining a robust API, ensuring changes are additive to avoid breaking the overall system of microservices.

- unit tests are self-contained, testing the handler functions that compose the overall API
- integration tests ensure external services continue to provide expected results and shape of responses
- end-to-end tests are very challenging when the system is first evolving, as design can change rapidly

> unit tests should not delay the rate at which you deploy your microservices

<!-- 
## why test

- ensure we are delivering value
- document the system, they are specifications - at different levels
- ensure the system works correctly

we test our ms so we can deplo with a sufficient level of confidence


- Outside in testing
start with your acceptance tests, that tell you whant your service is supposed to be doing
then work down through unit tests to code / repl

- executable specifications and living documents

- aggressive production monitoring
- eg some backs will send a $1 through the system to see what happens with the transaction, a small investment to test end to end the service and check if it works (picking your battles)


## feature files

Business requirements broken down into into features

- specific in the business content, general in the implementation

writing features is a collaborative effort, helping build up a common understanding and language


## Tools

Rest-Asured - testing restful web services
Serenity BDD reporting framework
swagger - uses annotations to document your api after the fact

-->
