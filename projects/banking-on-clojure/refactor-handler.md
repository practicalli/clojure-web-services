# Refactor to handlers namespace
Create a new namespace called request-handler which will contain all handler functions for the routes to be defined in the application.  Additional libraries will be used to create the responses, which will only be required in the new namespace.


Create a new file called `src/practicalli/request-handlers.clj`

<!-- Using `clj-new` command line tool -->

<!-- ```shell -->
<!-- clojure -R:new -m clj-new.generate ns=practicalli.request-handler -->
<!-- ``` -->

Move the  `[ring.util.response :refer [response]]` require and the handler function from `src/practicalli/banking_on_clojure.clj` to `src/practicalli/handlers.clj`

```clojure
(ns practicalli.handlers
  (:require [ring.util.response :refer [response]]))
```

```clojure
(defn welcome-page
  [request]
  (response "Banking on Clojure"))
```


Add the `practicalli.request-handler` namespace to `practicalli.banking-on-clojure` namespace, using the alias `handler`

```clojure
(ns practicalli.banking-on-clojure
  (:gen-class)
  (:require [org.httpkit.server :as app-server]
            [compojure.core :refer [defroutes GET]]
            [ring.util.response :refer [response]]
            [practicalli.request-handler :as handler]))
```

Update the request routing code to use the new alias for handlers

```clojure
(defroutes app
  (GET "/" [] handlers/welcome-page))
```

Restart the server to pick up the changes

```clojure
(app-server-restart "8888")
```

Check the server is still working by visiting http://localhost:8888/
