# Add a main function to run Jetty

> **Note**  Add a function called `-main` to the  `src/todo_list/core.clj` file.

> The `-main` function takes a port number as an argument which we pass when running the application.  The Ring Jetty adaptor is used to run an instance of Jetty.  The `-main` function contains an anonymous function that takes any request and returns a _response map_.

![Ring - Adaptor and anonymous function](../images/clojure-ring-adaptor-anonymous-function.png)

A response map contains the following key / value pairs
  * `:status` - the result of the request, eg. 200 OK, 401 Not Found, etc 
  * `:body` - the content to be returned (web page, json, etc)
  * `:headers` - a map of standard headers included in any web browser response 

Edit the `src/todo_list/core.clj` file and add the following function, after the namespace definition.

```clojure
(defn -main
  "A very simple web server using Ring & Jetty"
  [port-number]
  (jetty/run-jetty
     (fn [request] {:status 200
                   :body "<h1>Hello, Clojure World</h1>  <p>Welcome to your first Clojure app.  This message is returned regardless of the request, sorry</p>"
                   :headers {}})
     {:port (Integer. port-number)}))
``` 

> **Hint** Using a `-` at the start of the `-main` function is a naming convention, helping you see which function is the entry point to your program.  Leiningen also looks for this -main function by default when running your application.

>  The `Integer.` function is a call to `java.lang.Integer`.  The `.` is a special form that tells Clojure to treat this name as a call to Java.  See [coersing types and java.lang](coersing-types-and-java-lang.html)

> The `jetty/run-jetty` function takes two arguments.  In our example, the first argument is an anonymous function that returns a map (the response to the browser request);  the second argument is a port number to run the jetty server on expressed as a Java Integer object.
