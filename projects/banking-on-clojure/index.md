# Banking on Clojure web application

![Banking on Clojure web application user interface](/images/banking-on-clojure-ui-account-overview.png)

> #### TODO::Project under construction
> Project actively being developed as part of the [Practicalli Study group WebApps](https://www.youtube.com/playlist?list=PLpr9V-R8ZxiCe9p9tFk24ChNSpGfanUbT).
> Code so far is shared on [practicalli/banking-on-clojure-webapp](https://github.com/practicalli/banking-on-clojure-webapp) GitHub repository

Building a Banking application using Clojure, spec, H2 (development) & Postgresql (live) databases and next.jdbc for SQL queries (migratus for db migrations).

The system infrastructure uses Jetty or HTTP-kit (making this switchable at runtime) and a component life cycle system (probably mount).

## Application Design (in progress)
Data Specifications created using `clojure.spec.alpha`

* Customer Details &#10004;
* Account holder &#10004;
* Bank account
* Multiple Bank accounts
* Credit Card
* Mortgate

Functions and function specifications using `clojure.spec.alpha`

* register-account-holder &#10004;
* open-credit-account
* open-savings-account
* open-credit-card-account
* open-mortgage-account
* Make a payment
* Send account notification
* Check for overdraft

Functions with specifications are instrumented to check arguments passed during function calls.

Generative testing is carried out via the [kaoch test runner](https://cljdoc.org/d/lambdaisland/kaocha/1.0.641/doc/1-introduction).


## Development Workflow
* Write a failing test &#10004;
* write mock data &#10004;
* write an function definition that returns the argument &#10004;
* run tests - tests should fail &#10004;
* write a spec for the functions argument - customer &#10004;
* write a spec for the return value &#10004;
* write a spec for relationship between args and return value
* replace the mock data with generated values from specification &#10004;
* update functions and make tests pass &#10004;
* instrument functions
* run specification checks
