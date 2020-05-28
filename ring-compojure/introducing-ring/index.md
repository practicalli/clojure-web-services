# Introducing Ring 

Web applications typically run on a web or application server, such as [Tomcat](http://tomcat.apache.org/) or [Jetty](http://www.eclipse.org/jetty/) that provide a [Java Servlet Container](https://en.wikipedia.org/wiki/Java_servlet).  The Ring library provides a way to use these servers without being tied to any specific implementation.  Ring provides a common way to 

* Write your application using Clojure functions and maps
* Run your application in an auto-reloading development server (wrap-reload)
* Compile your application into a Java Servlet application
* Package your application into a Java war file
* Use a selection of [middleware functions](https://github.com/ring-clojure/ring/wiki/Standard-middleware)
* Deploy your application in cloud environments like Heroku

In essence, Ring converts the requests that come from the browser into a Clojure map, the request map.  The request map may be passed through one or more middleware functions before being converted to a response map by a handler.  The response map may be processed by one or more middleware functions before being converted by Ring to a web server response.

![Ring conceptual view](../images/clojure-ring-concept.png)

In the following sections you will get a better understanding of

  - how to represent a handler 
  - what do requests and responses look like
  - how to seperate query parameters from the design of your web app


Ring is the current de facto standard library used to write web applications in Clojure. Higher level frameworks such as Compojure use Ring as a common basis.
