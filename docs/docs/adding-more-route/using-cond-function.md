# Using cond function

  Change the if function to `cond` and define additional routes you want to match on.  We will show you a `/goodbye` route, feel free to add your own.

  Edit the `src/webdev/core.clj` file and update the `greet` function as follows
  
```clojure 
(defn greet
  "A function to process all requests for the web server.  The default route / returns one message, /goodbye route another. for all other routes an error message is returned"
  [request]
  (cond
   (= "/" (:uri request))
   {:status 200
    :body "Hello, Clojure World.  I now update automatically"
    :headers {}}
   (= "/goodbye" (:uri request))
   {:status 200
    :body "This is the end, my old friend"
    :headers {}}
   :else
   {:status 404
    :body "Sorry, page not found"
    :headers {}}))
```

  Writing a big cond statement for all our routes would be really tedious and difficult to manage.  So lets look at Compojure.
  
  
