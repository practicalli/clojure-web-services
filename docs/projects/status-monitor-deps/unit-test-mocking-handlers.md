# Mocking in Unit Tests

The main focus of unit tests in a web application are the handler functions, passing requests to those functions and checking the responses.

All handler functions are passed a request object by default when using compojure `defroutes` function for routing.

If handler functions do not use arguments then you can test those handlers by simply passing an empty hash-map, `{}`.

For all other handler functions you can pass a request object or just specific parts of a request in a hash-map.


## Ring mock library

[ring-mock](https://github.com/ring-clojure/ring-mock) is a small library creating Ring request maps (Clojure hash-maps) to support unit testing. Generated hash-maps are examples of a ring request and used as arguments when calling the handler functions in tests.


## Add dev dependency

As ring-mock is a development only library, it should be added to an alias not included in the packaging of the project for production.

Edit the project `deps.edn` file in the project and add ring-mock to an alias called `:env/dev`, creating the alias if required.


```clojure
  :env/dev
  {:extra-deps {ring/ring-mock {:mvn/version "0.4.0"}}}
```

## Add namespace

Add the ring-mock.request namespace to any of the test namespaces mocking of requests will be useful.

Edit the `test/practicalli/status-monitor-service.clj` and add ring-mock as a required namespace in files `ns` form.

```clojure
(ns practicalli.status-monitor-service-test
  (:require [clojure.test :refer [deftest is testing]]
            [ring.mock.request :as  mock]
            [practicalli.status-monitor-service :as status-monitor]))
```

Add unit tests to check the handlers (which are going to be added next - TDD style)

```clojure
(deftest test-app
  (testing "main route"
    (let [response ((status-monitor/app) (request :get "/"))]
      (is (= 200 (:status response)))))

  (testing "not-found route"
    (let [response ((status-monitor/app) (request :get "/invalid"))]
      (is (= 404 (:status response))))))
```


## Examples

* [API: ring-mock](https://ring-clojure.github.io/ring-mock/ring.mock.request.html)

```clojure
(deftest your-handler-test
  (is (= (your-handler (mock/request :get "/doc/10"))
         {:status  200
          :headers {"content-type" "text/plain"}
          :body    "Your expected result"})))

(deftest your-json-handler-test
  (is (= (your-handler (-> (mock/request :post "/api/endpoint")
                           (mock/json-body {:foo "bar"})))
         {:status  201
          :headers {"content-type" "application/json"}
          :body    {:key "your expected result"}})))
```
