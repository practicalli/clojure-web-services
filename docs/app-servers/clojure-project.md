# New Clojure Project

Create a new Clojure project using Clojure CLI

=== "deps-new"
    Create a new project using the `:project/create` alias from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/) and the `app` template using [deps-new](https://github.com/seancorfield/deps-new)
    ```bash
    clojure -T:project/create :template app :name practicalli/web-service
    ```

=== "clj-new"
    Create a new project using the `:project/new` alias from [Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/) and the app template using [clj-new](https://github.com/seancorfield/clj-new)
    ```bash
    clojure -T:project/new :template app :name practicalli/web-service
    ```


## Add web server library

Add either Ring (Jetty) or Httpkit library as a project dependency to run an embedded server that listens to HTTP requests and passes those requests to the Clojure service.

=== "Jetty"
    Add a ring library that includes an embedded Jetty server.

    The [`ring/ring` library](https://clojars.org/ring){target=_blank} includes all ring libraries including the embedded Jetty server

    Edit the project `deps.edn` file and add the `ring/ring {:mvn/version "1.9.5"}` dependency to the top-level `:deps` key, which defines the libraries used to make the project.

    ```clojure
    {:paths ["src" "resources"]
     :deps {org.clojure/clojure {:mvn/version "1.11.3"}
            ring/ring           {:mvn/version "1.9.6"}}}
    ```

    Or add the `ring/ring-core` and `ring/ring-jetty-adapter` libraries, saving a few millisecond when starting the project.
    ```clojure
    {:paths ["src" "resources"]
     :deps {org.clojure/clojure     {:mvn/version "1.11.3"}
            ring/ring-core          {:mvn/version "1.9.6"}
            ring/ring-jetty-adapter {:mvn/version "1.9.6"}}}
    ```


=== "HTTP Kit"
    Add the HTTP Kit Server library which includes the client and server namespaces, although only the Server namespace will be used.

    Edit the project `deps.edn` file and add the `http-kit/http-kit {:mvn/version "2.3.0"}` dependency to the top-level `:deps` key, which defines the libraries used to make the project.

    ```clojure
    {:paths ["src" "resources"]
     :deps {org.clojure/clojure {:mvn/version "1.11.3"}
            http-kit/http-kit   {:mvn/version "2.3.0"}}}
    ```

## Ring library

Ring is a Clojure web applications library inspired by Python's WSGI and Ruby's Rack. By abstracting the details of HTTP into a simple, unified API, Ring allows web applications to be constructed of modular components that can be shared among a variety of applications, web servers, and web frameworks.

[Ring interface specification](https://github.com/ring-clojure/ring/blob/master/SPEC){target=_blank .md-button}

Ring is composed of several libraries which can be included specifically, rather than requiring all of them with ring/ring

* `ring/ring-core` - essential functions for handling parameters, cookies and more
* `ring/ring-devel` - functions for developing and debugging Ring applications
* `ring/ring-servlet` - construct Java servlets from Ring handlers
* `ring/ring-jetty-adapter` - a Ring adapter that uses the Jetty webserver

[Ring documentation](https://github.com/ring-clojure/ring/wiki){target=_blank .md-button}
[Ring API docs](https://ring-clojure.github.io/ring/){target=_blank .md-button}
