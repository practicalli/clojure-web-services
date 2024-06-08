# Unit Test handler functions

Handler functions can be tested with unit tests as they are just pure functions.  All handlers take a request hash-map and return a response hash-map.  So its easy to give each handler a hash-map as an argument and test that we get the expected response hash-map in return.

There is no need to mock the framework until we do integration level testing, where we are testing the full lifecycle of request-response.

It is useful to have separate unit and integration tests to quickly narrow down the root cause of issues.

## Unit test branch

The unit tests are placed under `test/full_namespace_path/` and reside in files with the same names as the source code filenames, with `-test` postfixed to the end.

```bash
src/practicalli/simple_webapp/handlers.clj
test/practicalli/simple_webapp/handlers-test.clj
```

## Writing unit tests

`clojure.test` is used to write unit tests for handlers, as we are just treating them as functions.
