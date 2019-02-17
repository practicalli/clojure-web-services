# What is in a Request

The ring library converts the HTTP request into a clojure map, making it really easy to extract some or all of the values out of the request map.

## ring parameters

The wrap-params middleware function adds support for url-encoded parameters.

URL-encoded parameters are the primary way browsers pass values to web applications. These paramters are sent when a user submits a form.

When applied to a handler, the parameter middleware adds three new keys to the request map:

* :query-params - A map of parameters from the query string
* :form-params - A map of parameters from submitted form data
* :params - A merged map of all parameters

## viewing ring parameters

You could write a function to simply display all the parameters as the body of the response.  However Ring already provides a function to do this called `handle-dump`

To use the `handle-dump` function, first include the function in the namespace using `(:require [ring.handler.dump :refer [handle-dump]])`

> ####Note:: Add the `ring.handler.dump/handle-dump` function into the `shorturl-service.handler` namespace along with other require statements

```clojure
(ns shorturl-service.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [ring.handler.dump :refer [handle-dump]]))
```

As we have multiple `:require` statements we can simply chain them all together as above.
