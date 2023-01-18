# Test app reloading

The compojure template added several middleware functions to our project to make the webapp easier to work with.  The `wrap-reload` middleware picks up changes to our code and will automatically load them into our running webapp.  This provides rapid feedback on your coding.

> ####Note:: Make a simple change to the `app-routes` function in `src/shorturl-service/handler.clj` file, eg. change the "Hello World" string to "Hello reloaded World"

```clojure
(defroutes app-routes
  (GET "/" [] "Hello reloaded World")
  (route/not-found "Not Found"))
```

Now, refresh your browser and see the changes made.

> ####Hint:: You should only need to restart the server again if you add libraries or define code outside of the scope of the `app`.  Or if your code crashes the server, but I am sure that wont happen :)
