# A -main function to run Jetty web server

The Ring Jetty adaptor is used to run an instance of Jetty.  The `-main` function contains an anonymous function that takes any request and returns a _response map_.

The `-main` function takes a port number as an argument which we pass when running the application.

![Ring - Adaptor and anonymous function](../images/clojure-ring-adaptor-anonymous-function.png)

A response map contains the following key / value pairs
  * `:status` - the result of the request, eg. 200 OK, 401 Not Found, etc
  * `:body` - the content to be returned (web page, json, etc)
  * `:headers` - a map of standard headers included in any web browser response


> ####Note::  Add a function called `-main` to the  `src/todo_list/core.clj` file.
Edit the `src/todo_list/core.clj` file and add the following function, after the namespace definition.
>
```clojure
(defn -main
  "A very simple web server using Ring & Jetty"
  [port-number]
  (webserver/run-jetty
    (fn [request]
      {:status  200
       :headers {}
       :body    "<h1>Hello, Clojure World</h1>
                 <p>Welcome to your first Clojure app.
                 This message is returned regardless of the request, sorry</p>"})
    {:port  (Integer. port-number)
     :join? false}))
```

## Explaining the new function

  Using a `-` at the start of the `-main` function is a naming convention, helping you see which function is the entry point to your program.  Leiningen also looks for this -main function by default when running your application.

  The `webserver/run-jetty` function takes two arguments.  In our example, the first argument is an anonymous function that returns a map (the response to the browser request);  the second argument is a port number to run the jetty server on expressed as a Java Integer object.

  The `Integer.` function is a call to `java.lang.Integer`.  The `.` is a special form that tells Clojure to treat this name as a call to Java.  See [coersing types and java.lang](coersing-types-and-java-lang.html)

  The `:join? false` setting enables the REPL prompt to run after the web server starts.  By default the join setting is true and the running server would block access to the REPL prompt.
