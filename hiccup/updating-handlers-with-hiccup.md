# Updating handlers with hiccup

Instead of including fiddly html code (and having to make sure you close tags), we will write our markup in Clojure syntax using hiccup. 

## Add dependencies 

> **Note** Add hiccup dependencies 

```clojure
[hiccup "1.0.5"]
```

## Require hiccup 

> **Note** Add hiccup to your namespace 

```clojure
[hiccup.core :refer :all]
[hiccup.page :refer :all]
```

Your core.clj file should look like this

```clojure
(ns todo-list.core
  (:require [ring.adapter.jetty :as jetty]
            [ring.middleware.reload :refer [wrap-reload]]
            [compojure.core :refer [defroutes GET]]
            [compojure.route :refer [not-found]]
            [ring.handler.dump :refer [handle-dump]]
            [hiccup.core :refer :all]
            [hiccup.page :refer :all]))
```

## Update the welcome handler 

> **Note** Change the `welcome` handler to use hiccup rather than html code

```clojure
(defn welcome
  "A ring handler to respond with a simple welcome message"
  [request]
  (html [:h1 "Hello, Clojure World"]
        [:p "Welcome to your first Clojure app, I now update automatically"]))
```

The `html` function create html code based on the keywords used.  However, the html function does not create a full html web page.


## Update the goodbye handler 

> **Note** Change the `goodbye` handler to use hiccup rather than html 

```clojure
(defn goodbye
  "A song to wish you goodbye"
  [request]
    (html5 {:lang "en"}
           [:head (include-js "myscript.js") (include-css "mystyle.css")]
           [:body
            [:div [:h1 {:class "info"} "Walking back to happiness"]]
            [:div [:p "Walking back to happiness with you"]]
            [:div [:p "Said, Farewell to loneliness I knew"]]
            [:div [:p "Laid aside foolish pride"]]
            [:div [:p "Learnt the truth from tears I cried"]]]))
```

Using the `html5` function a complete html page is created, with a header and body section.

See the [hiccup.page API documentation](http://weavejester.github.io/hiccup/hiccup.page.html).
