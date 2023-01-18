# ring-mock

[`ring-mock`](https://github.com/ring-clojure/ring-mock) is a testing library for server-side applications


Ring-Mock creates Ring request maps to assist with defining tests in Clojure.

## Installation

Add the following development dependency to your `project.clj` file:

```clojure
[ring/ring-mock "0.3.2"]
```

## Examples

```clojure
(ns your-app.core-test
  (:require [clojure.test :refer :all]
            [your-app.core :refer :all]
            [ring.mock.request :as mock]))

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
