# Create project

To create a web service we can use two commonly used libraries in Clojure, [ring](/introducing-ring/) and [compojure](/compojure/).

Ring provides many low-level functions to manage web requests and responses as well as providing an embedded web server (ie. Jetty).  Most importantly it abstracts away all the complicated details of HTTP communication. So as a developer of the web app you mostly focus on processing a **request map** and returning a **response map**.

Compojure provides a simple way to define routes for your application, eg what function is called when a browser requests a specific url.

> ####Note:: Create a new project using Leiningen and the compojure template, then go into the project created.


```bash
lein new compojure shorturl-service

cd shorturl-service
```

Open the `project.clj` file in an editor and take a look at the dependencies added to the project.

```clojure
(defproject shorturl-service "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.8.0"]
                 [compojure "1.5.1"]
                 [ring/ring-defaults "0.2.1"]]
  :plugins [[lein-ring "0.9.7"]]
  :ring {:handler shorturl-service.handler/app}
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring/ring-mock "0.3.0"]]}})
```

Apart from Clojure itself, the compojure and ring libraries have been added.

The `:plugins` section adds `lein-ring` which allows us to run the server using the command `lein ring server`

The `:ring` section defines the default function to call when running the project

The `:profiles` section adds libraries useful for development and testing.
