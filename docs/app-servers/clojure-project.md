# New Clojure Project

Create a new Clojure project using Clojure CLI or Leiningen (the application code will be the same)

{% tabs cli="Cloure CLI", lein="Leiningnen" %}

{% content "cli" %}

Create a new project using the `:project/new` alias from [practicalli/clojure-deps-edn]({{book.P9IClojureDepsEdn}}) and the app template (uses [clj-new project](https://github.com/seancorfield/clj-new))

```bash
clojure -T:project/new :template app :name practicalli/web-service
```

{% content "lein" %}

Create a new project using [Leiningen](https://leiningen.org/) and the app template.

```bash
lein new app practicalli/web-service
```

{% endtabs %}


## Add web server library to main namespace

Add either Ring (Jetty) or Httpkit namespace to be able to call their respective functions to start a web server



### Add Ring Jetty dependency

Add a ring library which includes an embedded Jetty server.

Use either the [`ring/ring` library](https://clojars.org/ring) which includes all the various ring libraries, or only the specific [ring/jetty-adapter library](https://clojars.org/ring/ring-jetty-adapter) (keeping the project smaller overall).


{% tabs clijetty="Cloure CLI", leinjetty="Leiningnen" %}

{% content "clijetty" %}

Edit the project `deps.edn` file and add the `ring/ring {:mvn/version "1.9.5"}` dependency to the top-level `:deps` key, which defines the libraries used to make the project.

```clojure
{:paths ["src" "resources"]
 :deps {org.clojure/clojure {:mvn/version "1.11.0"}
        ring/ring           {:mvn/version "1.9.5"}}}
```


{% content "leinjetty" %}

Edit the `project.clj` file and add the `[ring/ring "1.9.5"]` dependency to the top-level `:dependencies` key, which defines the libraries used to make the project.

```clojure
(defproject practicalli/web-server "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.11.0"]
                 [ring/ring "1.9.5"]]
  :main ^:skip-aot practicalli.web-server
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})

```

{% endtabs %}



### Add Httpkit dependency

Add the Httpkit Server library which includes the client and server namespaces, although only the Server namespace will be used.

{% tabs clihttpkit="Cloure CLI", leinhttpkit="Leiningnen" %}

{% content "clihttpkit" %}

Edit the project `deps.edn` file and add the `http-kit/http-kit   {:mvn/version "2.3.0"}` dependency to the top-level `:deps` key, which defines the libraries used to make the project.

```clojure
{:paths ["src" "resources"]
 :deps {org.clojure/clojure {:mvn/version "1.11.0"}
        http-kit/http-kit   {:mvn/version "2.3.0"}}}
```


{% content "leinhttpkit" %}

Edit the `project.clj` file and add the `[http-kit "2.3.0"]` dependency to the top-level `:dependencies` key, which defines the libraries used to make the project.

```clojure
(defproject practicalli/web-server "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.11.0"]
                 [http-kit "2.3.0"]]
  :main ^:skip-aot practicalli.web-server
  :target-path "target/%s"
  :profiles {:uberjar {:aot :all
                       :jvm-opts ["-Dclojure.compiler.direct-linking=true"]}})

```

{% endtabs %}




<!-- ## Creating project with component lifecycle -->

<!-- TODO: create project with mount -->
<!-- TODO: create project with Integrant REPL and Integrant -->
<!-- TODO: create project with Stuart Siera Component and Component REPL -->
