# Refactored Core

We can now refactor the core namespace to contain the code that starts up our server and join up all the route handlers.

> ####Note:: Edit the `src/todo_list/core.clj` file and update the namespace defition to include the new `handlers` namespace, including the whole namespace in `core`.

```clojure
(ns todo-list.core
  (:require [compojure.core          :refer [routes]]
            [todo-list.handlers.play :refer [play-routes]]
            [todo-list.handlers.task :refer [task-routes]]
            [todo-list.handlers.base :refer [base-routes]]
            [ring.middleware.reload  :refer [wrap-reload]]
            [ring.adapter.jetty      :as    jetty]))
```

> ####Note:: Change app from a defroutes to a `def` and use the `route` function to merge all the defroutes into one

```clojure
(def app
  (routes #'play-routes #'base-routes #'task-routes))
```

The `routes` function takes the names of all the other defroutes and merges into one list of handlers.

`app` is now just a name we give to reference the handlers for all routes.  We can continue to add more defroutes to app as our application grows, along with any middleware we wish to apply to our handlers.

<hr />

`core` should be much smaller, containing only the route definition and the main app (plus the middleware around the app)



```clojure
(ns todo-list.core
  (:require [compojure.core          :refer [routes]]
            [todo-list.handlers.play :refer [play-routes]]
            [todo-list.handlers.task :refer [task-routes]]
            [todo-list.handlers.base :refer [base-routes]]
            [ring.middleware.reload  :refer [wrap-reload]]
            [ring.adapter.jetty      :as    jetty]))

(def app
  (routes #'play-routes #'base-routes #'task-routes))

(defn -main
  "A very simple web server using Ring & Jetty"
  [port-number]
  (jetty/run-jetty app
    {:port (Integer. port-number)}))

(defn -dev-main
  "A very simple web server using Ring & Jetty that reloads code changes via the development profile of Leiningen"
  [port-number]
  (jetty/run-jetty (wrap-reload #'app)
                   {:port (Integer. port-number)}))
```
