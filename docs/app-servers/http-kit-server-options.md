# Http-kit Server Options

Available options are defined in the [doc-string of org.httpkit.server/run-server](https://github.com/http-kit/http-kit/blob/master/src/org/httpkit/server.clj#L41-L63)

| Options                 | Description                                                                                                                                                                                                              |
|:------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `:ip `                  | Which ip (if has many ips) to bind                                                                                                                                                                            |
| `:port`                 | Which port listen incomming request                                                                                                                                                                           |
| `:thread`               | Http worker thread count                                                                                                                                                                                      |
| `:queue-size`           | Max job queued before reject to project self                                                                                                                                                                  |
| `:max-body`             | Max http body: 8m                                                                                                                                                                                             |
| `:max-ws`               | Max websocket message size                                                                                                                                                                                    |
| `:max-line`             | Max http inital line length                                                                                                                                                                                   |
| `:proxy-protocol`       | Proxy protocol e/o #{:disable :enable :optional}                                                                                                                                                              |
| `:worker-name-prefix`   | Worker thread name prefix                                                                                                                                                                                     |
| `:worker-pool`          | ExecutorService to use for request-handling (:thread, :worker-name-prefix, :queue-size are ignored if set)                                                                                                    |
| `:error-logger`         | Arity-2 fn (args: string text, exception) to log errors                                                                                                                                                       |
| `:warn-logger`          | Arity-2 fn (args: string text, exception) to log warnings                                                                                                                                                     |
| `:event-logger`         | Arity-1 fn (arg: string event name)                                                                                                                                                                           |
| `:event-names`          | map of HTTP-Kit event names to respective loggable event names                                                                                                                                                |
| `:server-header`        | The "Server" header. If missing, defaults to "http-kit", disabled if nil.                                                                                                                                 |
| `:legacy-return-value?` | true  (default) returns a (fn stop-server [& {:keys [timeout] :or {timeout 100}}]) ; false (recommended) Returns the HttpServer which can be used with `server-port`, ; `server-status`, `server-stop!`, etc. |


> See [Httpkit migration documentation](http://http-kit.org/migration.html) to see the minor difference between Http-kit server and other ring compliant servers like Jetty.
