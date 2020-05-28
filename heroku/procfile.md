# Add Procfile
The `Procfile` is a simple text file that instructs Heroku how to build and run an application.

Using the `web:` directive, we tell Heroku that our application will listen for web traffic (https).  Heroku sets a value for the port our application can listen to using the `PORT` configuration variable (ports are dynamically assigned).

> ####Note:: Create a new file called `Procfile` with the following text

```
web: java $JVM_OPTS -cp target/todo-list.jar clojure.main -m todo-list.core $PORT
```

## Theory: Running Clojure as a Java application

When you run a Clojure project with Leiningen, two Java virtual machines (JVM's) are started.  One JVM is to run Leiningen and the second JVM is to run your application.  By using Leiningen to run your application in production you are using use extra resources and also risk pulling in unnecessary development libraries & configuration only needed during development.

When you run your application in production you can save resources by only running a JVM for your application.  This is done by running a Clojure application just like a Java application, using the `java` command in the Heroku `Procfile`.


## Theory: Building Clojure

Building a Clojure project with Leiningen generates a Java `jar` file, a packaged version of your application.  A jar file generated from Java can be run using `java -jar jar-file-name.jar`.  However to run your Clojure jar file as a Java application you also need to include the the Clojure core library.

Leiningen can also generate an Uberjar.  The uberjar is a jar file that also includes the Clojure library as well as your application and libraries.  As the uberjar contains Clojure, you can run an uberjar in any Java environment.

By adding an `:uberjar` entry to the `project.clj` then the Leiningen command `lein uberjar` is run during the build and an uberjar is created.

When deploying on Heroku your application is built from your codebase using Leiningen, pulling in all the libraries your application depends on.  When your application is run it is done so as a Java application using only the uberjar, starting just the one JVM.

Further reading: https://devcenter.heroku.com/articles/clojure-support


## Theory: Identifying an entry point for your application

If your main namespace doesn’t have a `:gen-class` then you can use `clojure.main` as your entry point and indicate your app’s main namespace using the -m argument in your Procfile:

```
web: java $JVM_OPTS -cp target/myproject-standalone.jar clojure.main -m myproject.web
```
