## Refactor handlers and unit tests
Refactor the unit tests to use the ring-mock library to test handler functions.  Create separate handler functions for the routes in `defroute` (there is only one custom handler at present).

```clojure
(deftest dashboard-test
  (testing "Testing elements on the dashboard"
    (is (= (SUT/dashboard (mock/request :get "/"))
           {:status  200
            :body    "Status Monitor Dashboard"
            :headers {}}))))
```

Create a handler for the `GET "/"` route

```clojure
(defn dashboard
  [request]
  {:status (:OK http-status-code) :body "Status Monitor Dashboard" :headers {}})
```

Use the `ring.util.response/response` function to create a well formed response map which has a status code of 200.  This removes the need to type in the response map structure explicitly which potentially can introduce bugs.

In the current namespace `ns` form, this function is required as an explicit refer, `[ring.util.response :refer [response]]`, so its available to use by its unqualified name, `response`.

```clojure
(defn dashboard
  [request]
  (response "Status Monitor Dashboard"))
```


Update the `defroutes` definition to call this handler rather than hard coding the response map.

```clojure
(defroutes status-monitor
  (GET "/" [] dashboard)
  (GET "/request-dump" [] handle-dump)
  )
```

Run the Cognitect test runner to check the unit tests are still passing after the code refactor.

```clojure
clojure -A:dev:test:runner
```


## Reference: Additional helper functions
The ring util library contains several other helper functions, `bad-request`, `not-found` and `redirect`:

```clojure
(ring.util.response/bad-request "Hello")
;;=> {:status 400, :headers {}, :body "Hello"}

(ring.util.response/created "/post/clojure-is-awesome")
;;=> {:status 201, :headers {"Location" "/post/clojure-is-awesome"}, :body nil}

(ring.util.response/redirect "https://clojure.org/getting-started/")
;;=> {:status 302, :headers {"Location" "https://clojure.org/getting-started/"}, :body ""}
```

The `status` function converts an existing response to use a given status code (which can be anything).  Use this with care and document what the status code means otherwise confusion will abound.

```clojure
(ring.util.response/status (ring.util.response/response "Time for Cake!") 555)
;;=> {:status 555, :headers {}, :body "Time for Cake!"}
```

Ring utilites has functions for setting the header data for responses, `content-type`, `header` or `set-cookie`.

```clojure
(ring.util.response/content-type (ring.util.response/response "Hello") "text/plain")
;;=>  {:status 200, :headers {"Content-Type" "text/plain"}, :body "Hello"}

(ring.util.response/header (ring.util.response/response "Hello") "X-Tutorial-For" "Baeldung")
;;=>  {:status 200, :headers {"X-Tutorial-For" "Baeldung"}, :body "Hello"}

(ring.util.response/set-cookie (ring.util.response/response "Hello") "User" "123")
;;=>  {:status 200, :headers {}, :body "Hello", :cookies {"User" {:value "123"}}}

```

> #### Hint::`wrap-cookies` middleware required
> The `set-cookie` function adds a new entry to the response map and requires the `wrap-cookies` middleware to process correctly.


## Reference: handler functions

A handler to return the incoming IP Address

```clojure
(defn check-ip-handler [request]
    (ring.util.response/content-type
        (ring.util.response/response (:remote-addr request))
        "text/plain"))
```



<!-- ## Reference: middleware -->

<!-- Middleware is a name that's common in some languages but less so in the Java world. Conceptually they are similar to Servlet Filters and Spring Interceptors. -->

<!-- In Ring, middleware refers to simple functions that wrap the main handler and adjusts some aspects of it in some way. This could mean mutating the incoming request before it's processed, mutating the outgoing response after it's generated or potentially doing nothing more than logging how long it took to process. -->

<!-- In general, middleware functions take a first parameter of the handler to wrap and returns a new handler function with the new functionality. -->

<!-- The middleware can use as many other parameters as needed. For example, we could use the following to set the Content-Type header on every response from the wrapped handler: -->

<!-- (defn wrap-content-type [handler content-type] -->
<!--   (fn [request] -->
<!--     (let [response (handler request)] -->
<!--       (assoc-in response [:headers "Content-Type"] content-type)))) -->

<!-- Reading through it we can see that we return a function that takes a request – this's the new handler. This will then call the provided handler and then return a mutated version of the response. -->

<!-- We can use this to produce a new handler by simply chaining them together: -->

<!-- (def app-handler (wrap-content-type handler "text/html")) -->

<!-- Clojure also offers a way to chain many together in a more natural way – by the use of Threading Macros. These are a way to provide a list of functions to call, each with the output of the previous one. -->

<!-- In particular, we want the Thread First macro, ->. This will allow us to call each middleware with the provided value as the first parameter: -->

<!-- (def app-handler -->
<!--   (-> handler -->
<!--       (wrap-content-type "text/html") -->
<!--       wrap-keyword-params -->
<!--       wrap-params)) -->

<!-- This has then produced a handler that's the original handler wrapped in three different middleware functions. -->


<!-- ## Serving Static Resources -->

<!-- One of the simplest functions that any web application can perform is to serve up static resources. Ring provides two middleware functions to make this easy – wrap-file and wrap-resource. -->

<!-- The wrap-file middleware takes a directory on the filesystem. If the incoming request matches a file in this directory then that file gets returned instead of calling the handler function: -->

<!-- (use 'ring.middleware.file) -->

<!-- (def app-handler (wrap-file your-handler "/var/www/public")) -->

<!-- In a very similar manner, the wrap-resource middleware takes a classpath prefix in which it looks for the files: -->

<!-- (use 'ring.middleware.resource) -->

<!-- (def app-handler (wrap-resource your-handler "public")) -->

<!-- In both cases, the wrapped handler function is only ever called if a file isn't found to return to the client. -->

<!-- Ring also provides additional middleware to make these cleaner to use over the HTTP API: -->

<!-- (use 'ring.middleware.resource -->
<!--      'ring.middleware.content-type -->
<!--      'ring.middleware.not-modified) -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       (wrap-resource "public") -->
<!--       wrap-content-type -->
<!--       wrap-not-modified) -->

<!-- The wrap-content-type middleware will automatically determine the Content-Type header to set based on the filename extension requested. The wrap-not-modified middleware compares the If-Not-Modified header to the Last-Modified value to support HTTP caching, only returning the file if it's needed. -->
<!-- 4.2. Accessing Request Parameters -->

<!-- When processing a request, there are some important ways that the client can provide information to the server. These include query string parameters – included in the URL and form parameters – submitted as the request payload for POST and PUT requests. -->

<!-- Before we can use parameters, we must use the wrap-params middleware to wrap the handler. This correctly parses the parameters, supporting URL encoding, and makes them available to the request. This can optionally specify the character encoding to use, defaulting to UTF-8 if not specified: -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       (wrap-params {:encoding "UTF-8"}) -->
<!--   )) -->

<!-- Once done, the request will get updated to make the parameters available. These go into appropriate keys in the incoming request: -->

<!--     :query-params – The parameters parsed out of the query string -->
<!--     :form-params – The parameters parsed out of the form body -->
<!--     :params – The combination of both :query-params and :form-params -->

<!-- We can make use of this in our request handler exactly as expected. -->

<!-- (defn echo-handler [{params :params}] -->
<!--     (ring.util.response/content-type -->
<!--         (ring.util.response/response (get params "input")) -->
<!--         "text/plain")) -->

<!-- This handler will return a response containing the value from the parameter input. -->

<!-- Parameters map to a single string if only one value is present, or to a list if multiple values are present. -->

<!-- For example, we get the following parameter maps: -->

<!-- // /echo?input=hello -->
<!-- {"input "hello"} -->

<!-- // /echo?input=hello&name=Fred -->
<!-- {"input "hello" "name" "Fred"} -->

<!-- // /echo?input=hello&input=world -->
<!-- {"input ["hello" "world"]} -->

<!-- ## File Uploads -->

<!-- Often we want to be able to write web applications that users can upload files to. In the HTTP protocol, this is typically handled using Multipart requests. These allow for a single request to contain both form parameters and a set of files. -->

<!-- Ring comes with a middleware called wrap-multipart-params to handle this kind of request. This is similar to the way that wrap-params parses simple requests. -->

<!-- wrap-multipart-params automatically decodes and stores any uploaded files onto the file system and tells the handler where they are for it to work with them: -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-params -->
<!--       wrap-multipart-params -->
<!--   )) -->

<!-- By default, the uploaded files get stored in the temporary system directory and automatically deleted after an hour. Note that this does require that the JVM is still running for the next hour to perform the cleanup. -->

<!-- If preferred, there's also an in-memory store, though obviously, this risks running out of memory if large files get uploaded. -->

<!-- We can also write our storage engines if needed, as long as it fulfills the API requirements. -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-params -->
<!--       (wrap-multipart-params {:store ring.middleware.multipart-params.byte-array/byte-array-store}) -->
<!--   )) -->

<!-- Once this middleware is set up, the uploaded files are available on the incoming request object under the params key. This is the same as using the wrap-params middleware. This entry is a map containing the details needed to work with the file, depending on the store used. -->

<!-- For example, the default temporary file store returns values: -->

<!--   {"file" {:filename     "words.txt" -->
<!--            :content-type "text/plain" -->
<!--            :tempfile     #object[java.io.File ...] -->
<!--            :size         51}} -->

<!-- Where the :tempfile entry is a java.io.File object that directly represents the file on the file system. -->
<!-- ## Working With Cookies -->

<!-- Cookies are a mechanism where the server can provide a small amount of data that the client will continue to send back on subsequent requests. This is typically used for session IDs, access tokens, or persistent user data such as the configured localization settings. -->

<!-- Ring has middleware that will allow us to work with cookies easily. This will automatically parse cookies on incoming requests, and will also allow us to create new cookies on outgoing responses. -->

<!-- Configuring this middleware follows the same patterns as before: -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-cookies -->
<!--   )) -->

<!-- At this point, all incoming requests will have their cookies parsed and put into the :cookies key in the request. This will contain a map of the cookie name and value: -->

<!-- {"session_id" {:value "session-id-hash"}} -->

<!-- We can then add cookies to outgoing responses by adding the :cookies key to the outgoing response. We can do this by creating the response directly: -->

<!-- {:status 200 -->
<!--  :headers {} -->
<!--  :cookies {"session_id" {:value "session-id-hash"}} -->
<!--  :body "Setting a cookie."} -->

<!-- There's also a helper function that we can use to add cookies to responses, in a similar way to how earlier we could set status codes or headers: -->

<!-- (ring.util.response/set-cookie -->
<!--     (ring.util.response/response "Setting a cookie.") -->
<!--     "session_id" -->
<!--     "session-id-hash") -->

<!-- Cookies can also have additional options set on them, as needed for the HTTP specification. If we're using set-cookie then we provide these as a map parameter after the key and value. The keys to this map are: -->

<!--     :domain – The domain to restrict the cookie to -->
<!--     :path – The path to restrict the cookie to -->
<!--     :secure – true to only send the cookie on HTTPS connections -->
<!--     :http-only – true to make the cookie inaccessible to JavaScript -->
<!--     :max-age – The number of seconds after which the browser deletes the cookie -->
<!--     :expires – A specific timestamp after which the browser deletes the cookie -->
<!--     :same-site – If set to :strict, then the browser won't send this cookie back with cross-site requests. -->

<!-- (ring.util.response/set-cookie -->
<!--     (ring.util.response/response "Setting a cookie.") -->
<!--     "session_id" -->
<!--     "session-id-hash" -->
<!--     {:secure true :http-only true :max-age 3600}) -->

<!-- ## Sessions -->

<!-- Cookies give us the ability to store bits of information that the client sends back to the server on every request. A more powerful way of achieving this is to use sessions. These get stored entirely on the server, but the client maintains the identifier that determines which session to use. -->

<!-- As with everything else here, sessions are implemented using a middleware function: -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-session -->
<!--   )) -->

<!-- By default, this stores session data in memory. We can change this if needed, and Ring comes with an alternative store that uses cookies to store all of the session data. -->

<!-- As with uploading files, we can provide our storage function if needed. -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-cookies -->
<!--       (wrap-session {:store (cookie-store {:key "a 16-byte secret"})}) -->
<!--   )) -->

<!-- We can also adjust the details of the cookie used to store the session key. -->

<!-- For example, to make it so that the session cookie persists for one hour we could do: -->

<!-- (def app-handler -->
<!--   (-> your-handler -->
<!--       wrap-cookies -->
<!--       (wrap-session {:cookie-attrs {:max-age 3600}}) -->
<!--   )) -->

<!-- The cookie attributes here are the same as supported by the wrap-cookies middleware. -->

<!-- Sessions can often act as data stores to work with. This doesn't always work as well in a functional programming model, so Ring implements them slightly differently. -->

<!-- Instead, we access the session data from the request, and we return a map of data to store into it as part of the response. This is the entire session state to store, not only the changed values. -->

<!-- For example, the following keeps a running count of how many times the handler has been requested: -->

<!-- (defn handler [{session :session}] -->
<!--   (let [count   (:count session 0) -->
<!--         session (assoc session :count (inc count))] -->
<!--     (-> (response (str "You accessed this page " count " times.")) -->
<!--         (assoc :session session)))) -->

<!-- Working this way, we can remove data from the session simply by not including the key. We can also delete the entire session by returning nil for the new map. -->

<!-- (defn handler [request] -->
<!--   (-> (response "Session deleted.") -->
<!--       (assoc :session nil))) -->
