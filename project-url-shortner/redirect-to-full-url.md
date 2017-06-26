# Redirect short URL to full web address

Adding a redirect is very easy to do with ring, as the ring library provides a function called `redirect` that takes a url as an argument

> **Note** Include the `ring.util.response/redirect` function into the `shorturl-service.handler` namespace so that we can simply call the `redirect` function

```clojure
(ns shorturl-service.handler
  (:require [compojure.core :refer :all]
            [compojure.route :as route]
            [ring.middleware.defaults :refer [wrap-defaults site-defaults]]
            [ring.handler.dump :refer [handle-dump]]
            [ring.util.response :refer [redirect]]))
```
