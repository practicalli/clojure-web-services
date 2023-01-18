## Debugging ring requests
Requests are Clojure hash-maps so are easy to extract data from in a meaningful way.

If getting unexpected results, checking the details received in the request is a fast way to diagnose issues by seeing the data. The ring/ring-devel library contains a `handle-dump` function which displays the request parameters in a web page.


## Add ring development library
Add the `:env/dev` alias to include the `ring/ring-devel` library as a dependency.  The ring-devel library includes functions for developing and debugging ring applications.


```clojure
 :deps
 {org.clojure/clojure {:mvn/version "1.10.3"}
  http-kit/http-kit   {:mvn/version "2.5.3"}
  ring/ring-core      {:mvn/version "1.9.5"}
  compojure/compojure {:mvn/version "1.6.2"}}

 :aliases
 {:env/dev
  {:extra-deps {ring/ring-devel {:mvn/version "1.8.1"}}}}
```



## Restart REPL after adding dependencies

Dependencies are only added to the classpath when the REPL process starts, unless using the [unofficial dependency hotload approach](https://practical.li/clojure/alternative-tools/clojure-cli/hotload-libraries.html)

Quit the REPL if it is already running

Start the REPL including the alias `:env/dev`.  For example, run a rich terminal UI using rebel readline which also starts an nREPL sever:

```bash
clojure -M:env/dev:repl/rebel
```

> `:repl/rebel` is defined in the user level configuration [practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn)


## Require the `ring.handler.dump` namespace
Require the `ring.handler.dump` namespace in the `ns` form of `practicalli.status-monitor-server` namespace and refer the specific `handle-dump` function.

```clojure
(ns practicalli.status-monitor-service
  (:gen-class)
  (:require
   [org.httpkit.server       :as    app-server]
   [compojure.core           :refer [defroutes GET]]
   [compojure.route          :refer [not-found]]
   [ring.handler.dump        :refer [handle-dump]]
   [ring.util.response       :refer [response]]
   [practicalli.helpers-http :refer [http-status-code]]))
```


## Add a route to show the request map
Add a route that shows the request information using the `handle-dump` function.

```clojure
(defroutes status-monitor
  (GET "/" [] {:status (:OK http-status-code) :body "Status Monitor Dashboard"})
  (GET "/request-dump" [] handle-dump))
```

(re)start the application server and visit the URL http://localhost:8080/request-dump

![Clojure Webapps - ring devel handle dump request map web page](/images/clojure-webapps-ring-develop-handle-dump-request-map-webpage.png)


The request map details are also printed to the REPL buffer

```clojure
{:remote-addr "127.0.0.1",
 :params {},
 :route-params {},
 :headers
 {"accept"
  "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
  "accept-encoding" "gzip, deflate",
  "accept-language" "en-US,en;q=0.5",
  "connection" "keep-alive",
  "cookie"
  "_ga=GA1.1.1141619352.1582159249; ring-session=0b3dc210-278e-4011-bc03-d8c2292b2c17; JSESSIONID=5RNxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxB; _gid=GA1.1.111111111.3333333333",
  "host" "localhost:8080",
  "upgrade-insecure-requests" "1",
  "user-agent"
  "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0"},
 :async-channel
 #object[org.httpkit.server.AsyncChannel 0x359a37c8 "/127.0.0.1:8080<->/127.0.0.1:38190"],
 :server-port 8080,
 :content-length 0,
 :compojure/route [:get "/request-dump"],
 :websocket? false,
 :content-type nil,
 :character-encoding "utf8",
 :uri "/request-dump",
 :server-name "localhost",
 :query-string nil,
 :body nil,
 :scheme :http,
 :request-method :get}
```
