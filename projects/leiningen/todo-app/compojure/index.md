# Compojure

  To make our webapp more useful we will add more functionality, which will require more routes.

  [Compojure](https://github.com/weavejester/compojure) is a library that works with Ring to manage

  * **routing** - running different code depending on the URL path recieved
  * **http method switching** - running different code based on the HTTP method (GET, POST, PUT, DELETE)

  Compojure also has convienience functions that make ring responses easier to generate.

  In this section we will update our project to use Compojure.

![Ring - Compojure routes](../images/clojure-ring-adaptor-middleware-route--handler-overview.png)

## Leiningen Templates

Templates can be used to create a project with a given set of dependencies as well as Clojure code.

There is a `compojure` template that gives you a basic running web application.  To use this template to create a new project use the following command, substituting your own project-name

```bash
lein new compojure project-name
```

This project contains ring and compojure.  The dependency for ring is `ring/site-defaults` which includes some sensible default settings for your application, eg security settings such as anti-forgery.

See the definition of [ring/site-defaults](https://github.com/ring-clojure/ring-defaults/blob/master/src/ring/middleware/defaults.clj) for further information.



## Resources

* [Learn X in minutes - Compojure](http://learnxinyminutes.com/docs/compojure/) - using httpkit (performance & scalability)
* [Webapps with Compojure & OM](http://zaiste.net/2014/02/web_applications_in_clojure_all_the_way_with_compojure_and_om/)
* [StackOverflow - What's the “big idea” behind compojure routes?](http://stackoverflow.com/questions/3488353/whats-the-big-idea-behind-compojure-routes)
