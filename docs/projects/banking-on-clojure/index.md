# Banking on Clojure web application

![Banking on Clojure web application user interface](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure-web-services/banking-on-clojure-ui-account-overview.png)

!!! WARNING "Work In Progress"
    Project actively being developed as part of the [Practicalli Study group WebApps](https://www.youtube.com/playlist?list=PLpr9V-R8ZxiCe9p9tFk24ChNSpGfanUbT).

    Code so far is shared on [practicalli/banking-on-clojure-webapp](https://github.com/practicalli/banking-on-clojure-webapp) GitHub repository

Building a Banking application using Clojure, spec, H2 (development) & Postgresql (live) databases and next.jdbc for SQL queries (migratus for db migrations).

The system infrastructure uses Jetty or HTTP-kit (making this switchable at runtime) and a component life cycle system (probably mount).

## Application Design (in progress)

Data Specifications created using `clojure.spec.alpha`


- [x] Customer Details
- [x] Account holder
- Bank account
- Multiple Bank accounts
- Credit Card
- Mortgate

Functions and function specifications using `clojure.spec.alpha`

- [x] register-account-holder
- open-credit-account
- open-savings-account
- open-credit-card-account
- open-mortgage-account
- Make a payment
- Send account notification
- Check for overdraft

Functions with specifications are instrumented to check arguments passed during function calls.

Generative testing is carried out via the [kaocha test runner](https://practical.li/clojure/testing/test-runners/kaocha-test-runner/){target=_blank}


## Development Workflow

- [x] Write a failing test
- [x] write mock data
- [x] write an function definition that returns the argument
- [x] run tests - tests should fail
- [x] write a spec for the functions argument - customer
- [x] write a spec for the return value
- write a spec for relationship between args and return value
- [x] replace the mock data with generated values from specification
- [x] update functions and make tests pass
- instrument functions
- run specification checks
