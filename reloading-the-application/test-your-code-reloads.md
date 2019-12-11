# Test the wrap-reload middleware

  Make a change to the `welcome` function code and check that it automatically reloads.

> ####Note::Change the default response text in the `welcome` function
> Open the webapp in the browser http://localhost:8000.
>
> Make a change to the code in the `welcome` function, alterning the text of the `:body` in the default request.
>
```clojure
(defn welcome
  "A ring handler to process all requests for the web server.
  If a request is for something other than `/` then an error message is returned"
  [request]
  (if (= "/" (:uri request))
    {:status  200
     :headers {}
     :body    "<h1>Hello, Clojure World</h1>
               <p>Welcome to your first Clojure app.</p>
               <p>I now reload changes automatically</p> "}
    {:status  404
     :headers {}
     :body    "<h1>This is not the page you are looking for</h1>
               <p>Sorry, the page you requested was not found!</p>"}))
```
>
>  Save the code change and refresh your browser page, you should now see the updated message.
