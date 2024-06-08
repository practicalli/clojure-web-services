# Testing our API

We used the `clojure-test` option when we created the project, so we will use this built in library.


## Writing tests

Writing tests is just the same as other Clojure applications.


```clojure
(deftest a-test

  (testing "Test GET request to /hello?name={a-name} returns expected response"
    (let [response (app (-> (mock/request :get  "/api/plus?x=1&y=2")))
          body     (parse-body (:body response))]
      (is (= (:status response) 200))
      (is (= (:result body) 3)))))
```

## Using helper functions

It is good practice to create helper functions to extract out common code into its onw function.  This saves on duplication, reduces maintenance and should improve the readability of your tests.


Here is an example of a helper function that reads data in the form of JSON and creates a Clojure map for us to work with.

```clojure
(defn parse-body [body]
  (cheshire/parse-string (slurp body) true))
```

> ####HINT::Cheshire API
> See the [parse-string description in the Cheshire API documentation](http://dakrone.github.io/cheshire/cheshire.core.html#var-parse-string)


## Including test libraries in the namespace

Including the testing libraries is standard `:require` statements.

```clojure
(ns my-api.core-test
  (:require [cheshire.core :as cheshire]
            [clojure.test :refer :all]
            [my-api.handler :refer :all]
            [ring.mock.request :as mock]))
```


## `ring.mock` library

A library to help you mock parts of your server-side application.  This works just as well for APIs as web applications.


> ####HINT::Writing files in Clojure with spit
> [`spit`](https://clojuredocs.org/clojure.core/spit) is a simple function that will write files.
