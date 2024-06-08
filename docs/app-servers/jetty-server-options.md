# Jetty Server Options

Option keys available to pass to the `run-jetty` function from [`ring.adaptor.jetty`](https://github.com/ring-clojure/ring/blob/master/ring-jetty-adapter/src/ring/adapter/jetty.clj#L163-L210)


| Option                        | Description                                                                                                        |
|:------------------------------|:-------------------------------------------------------------------------------------------------------------------|
| `:configurator`               | a function called with the Jetty Server instance                                                                   |
| `:async?`                     | if true, treat the handler as asynchronous                                                                         |
| `:async-timeout`              | async context timeout in ms (defaults to 0, no timeout)                                                            |
| `:async-timeout-handler`      | an async handler to handle an async context timeout                                                                |
| `:port`                       | the port to listen on (defaults to 80)                                                                             |
| `:host`                       | the hostname to listen on                                                                                          |
| `:join?`                      | blocks the thread until server ends (defaults to true)                                                             |
| `:daemon?`                    | use daemon threads (defaults to false)                                                                             |
| `:http?`                      | listen on :port for HTTP traffic (defaults to true)                                                                |
| `:ssl?`                       | allow connections over HTTPS                                                                                       |
| `:ssl-port`                   | the SSL port to listen on (defaults to 443, implies :ssl? is true)                                                 |
| `:ssl-context`                | an optional SSLContext to use for SSL connections                                                                  |
| `:exclude-ciphers`            | when :ssl? is true, additionally exclude these cipher suites                                                       |
| `:exclude-protocols`          | when :ssl? is true, additionally exclude these protocols                                                           |
| `:replace-exclude-ciphers?`   | when true, :exclude-ciphers will replace rather than add to the cipher exclusion list (defaults to false)          |
| `:replace-exclude-protocols?` | when true, :exclude-protocols will replace rather than add to the protocols exclusion list (defaults to false)     |
| `:keystore`                   | the keystore to use for SSL connections                                                                            |
| `:keystore-type`              | the keystore type (default jks)                                                                                    |
| `:key-password`               | the password to the keystore                                                                                       |
| `:keystore-scan-interval`     | if not nil, the interval in seconds to scan for an updated keystore                                                |
| `:thread-pool`                | custom thread pool instance for Jetty to use                                                                       |
| `:truststore`                 | a truststore to use for SSL connections                                                                            |
| `:trust-password`             | the password to the truststore                                                                                     |
| `:max-threads`                | the maximum number of threads to use (default 50)                                                                  |
| `:min-threads`                | the minimum number of threads to use (default 8)                                                                   |
| `:max-queued-requests`        | the maximum number of requests to be queued                                                                        |
| `:thread-idle-timeout`        | Set the maximum thread idle time. Threads that are idle for longer than this period may be stopped (default 60000) |
| `:max-idle-time`              | the maximum idle time in milliseconds for a connection (default 200000)                                            |
| `:client-auth`                | SSL client certificate authenticate, may be set to :need,:want or :none (defaults to :none)                        |
| `:send-date-header?`          | add a date header to the response (default true)                                                                   |
| `:output-buffer-size`         | the response body buffer size (default 32768)                                                                      |
| `:request-header-size`        | the maximum size of a request header (default 8192)                                                                |
| `:response-header-size`       | the maximum size of a response header (default 8192)                                                               |
| `:send-server-version?`       | add Server header to HTTP response (default true)                                                                  |
