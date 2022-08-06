# Ring specification

Information to complement the [ring projects](https://github.com/ring-clojure)

Ring provides a defacto web standard that the majority of server-side web appliications use 

* request
* response
* handler
* middleware
* adaptor

Routing requests to handlers is typically managed by functions or libraries used in conjunction with ring, e.g reitit or compojure


## Ring request map

Ring represents HTTP requests as simple Clojure maps,
whose keys are drawn from the Java Servlet API 
and the official documentation RFC2616
– Hypertext Transfer Protocol
- HTTP/ 1.1 ( http:// www.w3. org/ Protocols/ rfc2616/ rfc2616. html ). 

A request map contains the following keys:

* :server-port: This is the port on which the request is being handled. 

* :server-name: This is the resolved name or IP address of the server handling the request. 
* :remote-addr: This is the IP address of the client, which is making the request. 
* :uri: This is the part of the address after the domain name. For example, for the address http:// ryans.io/ some/ beautiful/ uri, the request map's :uri would be /some/ beautiful/uri. 
* :query-string: This is the HTTP query string of the request, if one exists. For example, for the address http:// ryans.io/ some/ beautiful/ uri? color = blue& favPrime =7, the request map's :query-string would be color = blue& favPrime =7. 
* :scheme: This is the protocol used to make the request as a keyword; :http for HTTP request, and :https for Secure HTTP. 
* :request-method: This is the HTTP method used to make the request as keyword, so it will be one of :get, :post, :put, :delete, :head, or :options keys. 
* :headers: map of the header names (lowercase string) to header values (also string). e.g: `{: headers {" content-type" "text/ html" "content-length" "500" "pragma" "no-cache"}}` 
* :body: a string of any contents in the request body itself (such as the contents of an HTTP POST request). 


Request maps are not restricted to these top level keys.  Middleware is commonly used to mutate the request map by adding keys. 

## Response maps 

Ring represents an HTTP response as a simple Clojure map. 

The response map contains only three keys: 

* `:status` HTTP status code of the response as an integer, such as 200 or 403. A full list of HTTP status codes is made available as part of the RFC2616, and can be viewed at http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html.  
* `:headers` contains a map of header names (string) to header values, similar to the request map. 
* `:body` the body of the response as one of the following four types, and the behavior will change for each: 
  * String - the body is sent directly to client 
  * ISeq - each element of the sequence is sent to client as a String 
  * File - contents of the file sent to client 
  * InputStream - contents of the stream sent to the client, after which the stream is closed 

An example of a simple Hello World! response map can look like this: 

```clojure
{:status 200 
 :headers {" Content-Type" "text/ html"} 
 :body "<html><body><h1>Hello World!</h1></body></html>"}
```

## Handlers 

A handler is a Clojure function that accepts a request map and returns a response map.

an example handler function: 

```clojure
(defn hello-world 
  "Returns an Hello World Response Map" 
  [request] 
  {:status 200 
   :headers {"Content-Type" "text/html"} 
   :body "<html><body><h1>Hello World</h1></body></html>"}) 
```

Handlers are the core of the application. 

Typically our URLs will map one-to-one with a handler. 

create a handler and configure a route to use that handler too generate a response.

Open the `src/practicalli/routes/home.clj` file. 

Above the call to defroutes, add the following handler: 

```clojure
(defn hello-world 
  [] 
  {:status 200 
   :headers {"Content-Type" "text/html"} 
   :body "<html><body><h1>Hello World</h1></body></html>"})
```

Define a get request for an `/about` URI route that calls the hello-world handler:

```clojure
(GET "/about" [] (foo-response)) 
```


Navigate to http://localhost:3000/about in a browser and see a simple Hello World! page.


## Middleware 

Middleware are functions that sit between the adapter and the handler and can be assigned to one or more routes. 

A middleware function accepts a handler function and returns a new handler function. 

Middleware functions can update the request or response map (adding keys, changingg values, coercing types or logging request and response maps) before passing it on to the handler function. 

An example: a middleware function which adds a `:friday?` key to the request map which is used in the hello-world handler : 

Edit the `src/practicalli/middleware.clj` file. 

Add the following middleware function, which takes a handler and returns a new handler function (which in turn adds a new key to the request map and calls the next handler in the chain): 


```clojure
(defn friday? 
  [handler] 
  (fn [request] 
  (let [request (assoc request :friday? true)] 
    (handler request)))) 
```


In the middleware definition add the friday? middleware function call: 

```clojure
(def middleware [go-bowling? wrap-error-page wrap-exceptions])
```

In the `src/practicalli/routes/home.clj` adjust the `:body` value in our hello-world handler to include a message based on the :friday? key value on the request map. 

Adjust the handler function parameters to accept the request map: 

```clojure
(defn hello-world 
  [request] 
  {:status 200 
   :headers {" Content-Type" "text/html"} 
   :body (str "<html><body> <dt>Is it Friday?</dt>""<dd >"(:friday? request)"</dd></body></html>")}) 
```

Change the `/about` route to make use of the request map: 

```clojure
(GET "/ about" request (hello-world request))
```

Refresh the browser page at http://localhost:3000/about and see the middleware in action! 

More information about middleware and how it's natively used in Ring at https://github.com/ring-clojure/ring/wiki/Concepts#middleware. 


## Adapters 

Adapters translate between the HTTP protocol and Clojure data, greatly simplifying all Clojure web applications.

An adapter converts an incoming HTTP request into a Clojure request hash-map and passes the request to the Clojure web application.  The adaptor converts the Clojure response hash-map into the appropriate servlet HTTP response, sending that HTTP respose back to the client. 

The Ring library comes with a Jetty adapter ([ring/ring-jetty-adapter "1.3.0"]) which sits between a Jetty servlet container and the rest of the application stack. 

Http-kit also provides a ring compatible adaptor for its HTTP server.

TODO: Add references for all the Clojure adaptors available for server-side applications, i.e jetty, http-kit, aleph, tomcat?, glassfish?, etc.

