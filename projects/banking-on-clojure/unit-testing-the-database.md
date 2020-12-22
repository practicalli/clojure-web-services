# Unit Testing with the Database


## Unit testing using clojure spec

Require the clojure.spec namespaces
* `[clojure.spec.alpha :as spec]` for the core spec functions, including `gen` for specification generators
* `[clojure.spec.gen.alpha :as spec-gen]` for generate and sample functions to generate values from specifications
* `[clojure.spec.test.alpha :as spec-test]` for running check on instrumented function definitions
* `[practicalli.specifications-banking]` for the banking related specifications

```clojure
(ns practicalli.database-access-test
  (:require
   ;; Unit testing
   [clojure.test :refer [deftest is testing]]

   ;; Clojure Specifications
   [clojure.spec.alpha :as spec]
   [clojure.spec.test.alpha :as spec-test]
   [clojure.spec.gen.alpha :as spec-gen]
   [practicalli.specifications-banking]

   ;; System under test
   [practicalli.database-access :as SUT])
  )
```

A simpler test to check that a map of generated values is returned when calling `new-account-holder`

```clojure
(deftest new-account-holder-test
  (testing "Registered account holder is valid specification"
    (is (map? (SUT/new-account-holder
                (spec-gen/generate
                  (spec/gen :practicalli.specifications-banking/customer-details)))))))
```

> This test alone will fail in a CI environment as the application does not create the database tables automatically


## In a continuous integration environment

A Continuous Integration environment will be empty to start with, so when using an embedded database the database and database tables need to be created each time the tests run.

Creating the tables each time the tests are run could lead to errors if the database already has those tables defined

![Table exists](/images/clojure-webapps-database-create-table-when-exists-error.png)


Add `IF NOT EXISTS` to the `CREATE TABLE` SQL statement so that the `create-tables!` function returns nil rather than an SQL error.

```clojure
(def schema-account-holders-table
  ["CREATE TABLE IF NOT EXISTS PUBLIC.ACCOUNT_HOLDERS(
     ACCOUNT_HOLDER_ID UUID DEFAULT RANDOM_UUID() NOT NULL,
     FIRST_NAME VARCHAR(32),
     LAST_NAME VARCHAR(32),
     EMAIL_ADDRESS VARCHAR(32) NOT NULL,
     RESIDENTIAL_ADDRESS VARCHAR(255),
     SOCIAL_SECURITY_NUMBER VARCHAR(32),
     CONSTRAINT ACCOUNT_HOLDERS_PK PRIMARY KEY (ACCOUNT_HOLDER_ID))"])
```





> Longer term: Run migratus scripts to establish the database schema each time.
