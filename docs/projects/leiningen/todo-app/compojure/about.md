# About route

> ####Note:: Write an about route and handler that gives you information about the app.
>
```clojure
(defn about
  "Information about the website developer"
  [request]
  {:status 200
   :headers {}
   :body "I am an awesome Clojure developer, well getting there..."})
```
>
> Add a route to call the about handler function
```clojure
(defroutes app
  (GET "/"        [] welcome)
  (GET "/goodbye" [] goodbye)
  (GET "/about"   [] about)
  (not-found "<h1>This is not the page you are looking for</h1>
              <p>Sorry, the page you requested was not found!</p>"))
```
