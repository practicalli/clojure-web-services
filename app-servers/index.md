# Application servers

Application servers (app servers) for Clojure run an embedded JVM application, such as Jetty or http-kit server.

App servers are started within the Clojure REPL process, so during development app servers can be restarted to load in new code and immediately update the running application.

![Clojure WebApps simplified stack]({{ book.P9IDeveloperGuides }}clojure/clojure-webapps/clojure-web-apps-stack.png)

> #### Hint::Embedded servers in Clojure
> Clojure takes a more distributed approach to deployment, starting an embedded application server within the application itself.  This approach is more conducive to the container and cloud compute infrastructure.  Scaling is achieved by running multiple instances of the application, each on its own embedded application server.
>
> In Java was common to have a single application server with all applications deployed as Jar or War archives.  This fitted with the classic architecture of deploying on a single resource rich physical hardware server.  Clojure applications can also be deployed in this classic approach if required.


## Which Application Server to use

The most commonly used application servers are in the table below, with Jetty being the most common as it is wrapped by the ring-clojure/ring library.

| Application Server                              | Description                                                                                                                        |
|-------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| [Eclipse Jetty](https://www.eclipse.org/jetty/) | The original embedded Java application server **most commonly used for Clojure web apps**                                          |
| [Http-kit](http://http-kit.github.io/)          | High performance Clojure/Java application server                                                                                   |
| [Apache Tomcat](http://tomcat.apache.org/)      | Classic Java application server, very common in JVM environments                                                                   |
| [Netty](https://netty.io/)                      | Java NIO asynchronous event-driven network application framework                                                                   |
| [Aleph HTTP](https://aleph.io/aleph/http.html)  | Clojure (Netty) Ring-compliant server with support for returning [Manifold](https://aleph.io/manifold/rationale.html) for asynchronous programming |


## Eclipse Jetty

![Jetty logo](https://www.eclipse.org/jetty/documentation/current/images/jetty-header-logo.png)

Jetty is the most commonly used application server on the Java Virtual machine.

[Eclipse Jetty](https://www.eclipse.org/jetty/) provides a Web server and javax.servlet container, plus support for HTTP/2, WebSocket, OSGi, JMX, JNDI, JAAS and many other integrations. These components are open source and available for commercial use and distribution.

Eclipse Jetty is used in a wide variety of projects and products, both in development and production. Jetty can be easily embedded in devices, tools, frameworks, application servers, and clusters. See the Jetty Powered page for more uses of Jetty.

The current recommended version for use is Jetty 9

## Http-kit

[HTTP Kit](http://http-kit.github.io/) is a minimalist, efficient, Ring-compatible HTTP client/server for Clojure.

HTTP Kit uses a event-driven architecture to support highly concurrent a/synchronous web applications. Feature a unified API for WebSocket and HTTP long polling/streaming

The underlying server is [implemented in Java](https://github.com/http-kit/http-kit/blob/master/src/java/org/httpkit/server/HttpServer.java) with a [Clojure wrapper](https://github.com/http-kit/http-kit/blob/master/src/org/httpkit/server.clj).


## Apache Tomcat

[![Apache Tomcat logo](https://tomcat.apache.org/res/images/tomcat.png)](http://tomcat.apache.org/)

[Apache Tomcat](http://tomcat.apache.org/) is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies. The Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket specifications are developed under the Java Community Process.

Apache Tomcat software powers numerous large-scale, mission-critical web applications across a diverse range of industries and organizations, example are listed on the [PoweredBy](https://cwiki.apache.org/confluence/display/TOMCAT/PoweredBy) page.

Apache Tomcat, Tomcat, Apache, the Apache feather, and the Apache Tomcat project logo are trademarks of the Apache Software Foundation.

Apache Tomcat 9.0 is the [current stable version](http://tomcat.apache.org/whichversion.html) with active development now on version 10.

Tomcat can be run in embedded mode, so it is not necessary to build a WAR file and deploy it in a standalone Tomcat server.

* [Create a Java Web Application Using Embedded Tomcat - Heroku](https://devcenter.heroku.com/articles/create-a-java-web-application-using-embedded-tomcat)

<!-- ## Netty -->
![Netty.io logo](/images/netty-logo.png)

[Netty](https://netty.io/) is an asynchronous event-driven network application framework for rapid development of maintainable high performance protocol servers & clients.

Netty is a NIO client server framework which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server.

![Netty components](https://netty.io/images/components.png)


## Aleph and Manifold

![Manifold and Aleph logo](https://aleph.io/images/aleph.svg)

Manifold provides streams focused libraries, such as Aleph HTTP for web applications and TCP/UDP for more general networking.

{% youtube %}
https://www.youtube.com/watch?v=1bNOO3xxMc0
{% endyoutube %}




<!-- ## Networks application layer -->

<!-- Ring -->
<!-- Yada -->

<!-- | [Aleph](https://aleph.io/aleph/http.html) | library for client and server network programming, built on top of Netty. I           | -->
