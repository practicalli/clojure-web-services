# Routing

Compojure
Bidi
Reitit


## Injecting resources using routing


```clojure
(defroutes
  GET /accounts/account [] (partial db/connection request))
```

And then have a handler that takes both a request and resource arguments.
This makes the handler pure in respect that it does not require any external data to do its job (yes the connection is external, but the reference to the connection is provided as an argument to the side effect is abstracted away).


Middleware could also be used to wrap all the routes, however, if some routes do not use the database then this approach adds redundancy and makes the abstraction feel too high a level in the application design.  This approach also makes it harder to test the handlers as normal Clojure functions, as its not possible to simply call that function with an argument.



## Resources
* [How to manage database connections in Clojure](https://clojureverse.org/t/how-to-manage-database-connection-in-clojure/5067) - ClojureVerse

* https://devcenter.heroku.com/articles/database-connection-pooling-with-clojure
* https://stackoverflow.com/questions/19776462/passing-state-as-parameter-to-a-ring-handler
