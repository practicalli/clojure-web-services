# Unit tests
In Clojure web applications the handler functions are the main focus of the unit tests.

Create the file `test/practicalli/request-handler-test.clj` to contain the unit tests.

Define the `request-handler-test` namespace, including other namespaces that should be required.

The `ring.mock.request` library is added to simulate request calls to the handlers.

```clojure
(ns practicalli.request-handler-test
  (:require [practicalli.request-handler :as SUT]
            [clojure.test :refer [deftest is testing]]
            [ring.mock.request :as mock]))
```

Add unit tests for each handler that will be created in `practicalli.request-handler`.

A simple starting point for tests is to check the correct HTTP status code is being returned.

`ring.mock.request` library contains a `request` function that will generate a mock request hash-map from a given HTTP protocol (:get :post etc.) and a address.

```clojure
(deftest welcome-page-test
  (testing "Testing elements on the welcome page"
    (is (= 200
           (:status (SUT/welcome-page (mock/request :get "/")))))))
```

## Ensuring a status code in handlers
The `ring.util.response` namespace is added to the `practicalli.request-handlers` namespace. This provide the `response` function which wraps the body (i.e. web page content) with a correctly formed response hash-map.

```clojure
(response "Web page content to be added to the response hash-map")
```

The `practicalli.request-handlers` namespace definition

```clojure
(ns practicalli.request-handler
  (:require [ring.util.response :refer [response]]
            [hiccup.core :refer [html]]
            [hiccup.page :refer [html5 include-js include-css]]
            [hiccup.element :refer [link-to]]))
```

The welcome page (`GET "/"`) content is defined with hiccup code to generate a HTML page (`html5`).  This content is wrapped by the `response` function to return a response hash-map.

```clojure
(defn welcome-page
  [request]
  (response
    (html5
      {:lang "en"}
      [:head
       (include-css "https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css")]
      [:body
       [:section {:class "hero is-info"}
        [:div {:class "hero-body"}
         [:div {:class "container"}
          [:h1 {:class "title"} "Banking on Clojure"]
          [:p {:class "subtitle"}
           "Making your money immutable"]]]]

       [:section {:class "section"}
        [:div {:class "container"}
         (link-to {:class "button is-primary"} "/accounts"    "Login")
         (link-to {:class "button is-danger"}  "/register" "Register")
         [:p {:class "content"}
          "Manage your money without unexpected side-effects using a simple made easy banking service"]
         [:img {:src "https://raw.githubusercontent.com/jr0cket/developer-guides/master/clojure/clojure-piggy-bank.png"}]]]])))
```

## Using Kaocha to run tests
[Kaocha](https://practicalli.github.io/clojure/testing/test-runners/kaocha-test-runner.html) was added as part of the [continuous integration configuration](continuous-integration.md) as a local binary.  This kaocha binary can be called to run the tests and check that all the handlers are returning the right status code.

```shell
bin/kaocha
```

kaocha should return the results of running all unit tests in the project.

If a handler does not return the correct status code, then kaocha will highlight the error in the unit test results.
![Clojure WebApps kaocha test runner failing test](/images/clojure-webapps-kaocha-test-run-fail-request-handler-status-code.png)

kaocha will show a summary of the results when all the tests are successful.

![Clojure WebApps kaocha test runner results](/images/clojure-webapps-kaocha-test-runner-output.png)
