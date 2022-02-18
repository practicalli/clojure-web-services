# Initial configuration
Projects containing application servers are typically started from the command line, especially when deployed.

During development an application server is typically managed via the REPL, either directly or via a component lifecycle service (mount, integrant, component)

The `-main` function is used to capture optional arguments to set configuration such as port and ip address.  These values can either be passed as function arguments, operating system environment variables or default values.

Define a `-main` function that optionally takes an argument that will be used as a port number to listen for requests.

A value is bound to the local name `port` using either the argument to the `-main` function, an operating system environment variable or the default port number.


```clojure
(defn -main
  "Start the application server on a specific port"
  [& [port]]
  (let [port (Integer. (or port
                           (System/getenv "PORT")
                           8080))]
    (app-server-start port)))
```

The `app-server-start` function starts a specific application server, eg. Jetty, http-kit-server.


## Set Port number to listen on
Application servers listen on a specific port for messages over HTTP/S which is set when starting the application server.  Public facing application will receive requests over port 80, although for security reasons a firewall or proxy is placed in front of the application server which redirects traffic to an internal port number for the application server.

Cloud application platforms (Heroku, Google, AWS) provide a port number each time a new cloud environment (eg. container) is provisioned, so an application server should read in this dynamically assigned port number from the provided operating system environment variable.


## Integer type port number
`(Integer. port-number)` will cast either a string or number to a JVM integer type.  `(Integer/parseInt port-number)` is also commonly used and has the same result.

These functions are used to ensure an Integer type value is passed to the application server.  As Clojure uses Java application servers (Java app servers have decades of development) then the correct type must be passed to avoid error.


## Get environment variables
A common way to get environment variables from the operating system is to use the Java method, `System/getenv`.

```clojure
(System/getenv "PORT") returns the value of the `PORT` environment variable.  If the variable is not set, then nil is returned (TODO: check what is actually returned)
```

![Clojure WebApps - set port in shell and read port using System/getenv function](clojure-webapps-application-server-port-system-getenv.png)

`System/getProperty` method will get specific values from Java `.properties` files, usually from a `system.properties` file in the root of the project.  `System/getProperties` will get all properties found in `.properties` files in the project. Settings typically found in the `system.properties` files include version of Java

```none
java.runtime.version=11
```

> [The Java Tutorials: Properties](https://docs.oracle.com/javase/tutorial/essential/environment/properties.html)


`(System/getenv)` returns a hash-map of all current environment variables.  Wrap in a `def` name to make a useful REPL tool to inspect the current environment variables available.

```clojure
(comment
  ;; Get all environment variables
  ;; use a data inspector to view environment-variables name
  (def environment-variables
    (System/getenv))
  )
```

Use tools such as [the clojure inspector](http://practicalli.github.io/clojure/clojure-tools/clojure-inspector.html) or data inspector tools in Clojure aware editors (e.g. CIDER inspector)


## Environ -  manage environment variables from multiple sources
[weavejester/environ library](https://github.com/weavejester/environ) will source environment settings from Leiningen and Boot, an Operating System and Java system properties.  The library works for Clojure and ClojureScript projects.

Require the library
```clojure
(require '[environ.core :refer [env]])
```

Then call the `env` function with a property name to return the value associated with that property.

```clojure
(env :port)
```
