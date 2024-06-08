# Create a handler function
So far we have just sent back the same response map.  To make our webapp more useful then we should have functions that return different web pages and resources (like JSON for API's).

In Ring terminology, these functions are referred to as a handler.  They handler a request and return a response.

When you send a request to the webapp, the ring adaptor converts this request to a map and sends it to the specified handler.

![Ring - Adaptor and Handler](../images/ring-basics-adaptor-handler-request-response.png)

A handler function takes the request map as its argument and returns a response map.

> ####Note::Add separate handler function
> Refactor the code in the `src/todo-list/core.clj` file to create a separate `welcome` handler function that processes all requests
>
```clojure
(defn welcome
  "A ring handler to process all requests sent to the webapp"
  [request]
  {:status  200
   :headers {}
   :body    "<h1>Hello, Clojure World</h1>
             <p>Welcome to your first Clojure app.
             This message is returned regardless of the request, sorry<p>"})
```
>
> Update the `-main` function to call the `welcome` function
>
```clojure
(defn -main
  "A very simple web server using Ring & Jetty"
  [port-number]
  (webserver/run-jetty
    welcome
    {:port  (Integer. port-number)
     :join? false}))
```



## Run the server again

  Save code changes and run the web server (use Control-c if you need to stop the server first)

```bash
lein run 8000
```

Your webapp should behave exactly as it did before, check by visiting http://localhost:8000.

![Clojure webapp - running todo-list project](/images/todo-list-lein-run-portnumber.png)

> #### Hint::Automatically reloading
> In the middleware section the `wrap-reload` ring middleware component is used to automatically reload code changes into the running application, so no need to restart the webserver unless we have to add a dependency.
