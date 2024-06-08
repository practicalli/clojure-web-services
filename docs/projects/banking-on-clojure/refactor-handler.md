# Refactor to handlers namespace

Create a new namespace called `practicalli.banking-on-clojure.handler` which will contain handler functions for the routes to be defined in the application.

Additional libraries will be used to create the responses, which will only be required in the new namespace.

Create a new file called `src/practicalli/banking_on_clojure/handler.clj`

Move the `[ring.util.response :refer [response]]` require and the handler function from `src/practicalli/banking_on_clojure/service.clj` to `src/practicalli/banking_on_clojure/handler.clj`

```clojure title="src/practicalli/banking_on_clojure/handler.clj"
(ns practicalli.banking-on-clojure.handler
  "Handler functions to satisfy requests to the service"
  (:require
    [ring.util.response :refer [response]]))
```

```clojure title="src/practicalli/banking_on_clojure/handler.clj"
(defn welcome-page
  "Main page layout for the service"
  [request]
  (response "Banking on Clojure"))
```


Require the `practicalli.banking-on-clojure.handler` namespace in `practicalli.banking-on-clojure` namespace, using the alias `handler`

```clojure title="src/practicalli/banking_on_clojure/service.clj"
(ns practicalli.banking-on-clojure
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]
            [ring.util.response :refer [response]]
            [practicalli.handler :as handler]))
```

Update the request routing code to use the new alias for handlers

```clojure title="src/practicalli/banking_on_clojure/service.clj"
(defroutes app
  (GET "/" [] handler/welcome-page))
```

Restart the server to pick up the changes

```clojure title="src/practicalli/banking_on_clojure/service.clj"
(app-server-restart "8888")
```

Check the server is still working by visiting http://localhost:8888/
