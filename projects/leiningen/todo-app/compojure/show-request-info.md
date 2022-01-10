# Show request info

We can see the details of the requests being send to our Clojure webapp by looking at the request object.

## request-info route

Add a `request-info` route and handler to view the request information

```clojure
(defn request-info
  "View the information contained in the request, useful for debugging"
  [request]
  {:status 200
   :body (pr-str request)
   :headers {}})

(defroutes app
  (GET "/" [] welcome)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] request-info)
  (not-found "<h1>This is not the page you are looking for</h1> <p>Sorry, the page you requested was not found!</p>"))
```

Visit http://localhost:8000/request-info to see the results.

![Output of the request](/images/clojure-webdev-request-info-pr-str-output.png)


## Using Compojure's request dump function

Compojure has a request dump function that gives a much nicer output than our initial `request-info` function.  The `dump` funtion also seperates the default response keys with any additional keys provided by the URL.

## Include `handle-dump` in the namespace

```clojure
(ns webdev.core
  (:require [ring.adapter.jetty :as jetty]
            [ring.middleware.reload :refer [wrap-reload]]
            [compojure.core :refer [defroutes GET]]
            [compojure.route :refer [not-found]]
            [ring.handler.dump :refer [handle-dump]]))
```

## Remove request-info function

Delete the `request-info` function we defined previously and update the `/request-info` route to use `handle-dump` as the handler

```clojure
(defroutes app
  (GET "/" [] welcome)
  (GET "/goodbye" [] goodbye)
  (GET "/about" [] about)
  (GET "/request-info" [] handle-dump)
  (not-found "<h1>This is not the page you are looking for</h1> <p>Sorry, the page you requested was not found!</p>"))
```

Now the output is much nicer http://localhost:8000/request-info

![Clojure Web Services - compojure request-dump output](/images/clojure-webdev-compojure-request-dump-output.png)
