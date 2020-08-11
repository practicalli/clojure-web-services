# Automatic reloading with wrap-reload middleware

 `wrap-reload` is a ring middleware function that will push all our code changes to the application each time we save.

![Ring - wrap-reload middleware](../images/clojure-ring-adaptor-middleware-handler-wrap-reload.png)


> ####Note::  Include wrap-reload in the namespace of our project
> Require the `wrap-reload` directly into the namespace
>
```clojure
(ns todo-list.core
  (:require [ring.adapter.jetty :as jetty]
            [ring.middleware.reload :refer [wrap-reload]]))
```

## Define a function to use wrap-reload

  A function called `-dev-main` will run the reloading web server when we are developing, ensuring we only use the `wrap-reload` function during development.


> ####Note:: Create a `-dev-main` function
> The `-dev-main` funciton is the same as `-main`, except we use the `wrap-reload` middleware around the `welcome` function.  Each time you change the `welcome` function definition it will be reloaded.
>
> Using the quote reader macro, **#'** in front of the `welcome` function name tells Clojure to skip evaluation of the function and reference the name of the function instead.  This allows the `wrap-reload` middleware to decide when to evaluate the `welcome` function.
>
```clojure
(defn -dev-main
  "A very simple web server using Ring & Jetty,
  called via the development profile of Leiningen
  which reloads code changes using ring middleware wrap-reload"
  [port-number]
  (webserver/run-jetty
    (wrap-reload #'welcome)
    {:port  (Integer. port-number)
     :join? false}))
```

> #### Note::Tweak the `-main` function for production
> The `-main` function is typically called on the command line when run in production, so we want to be connected to the output of the webserver.
>
> Remove the `:join? false` option for the embedded Jetty server, so the output of the server is displayed
>
```clojure
(defn -main
  "A very simple web server using Ring & Jetty
  Production mode operation, no reloading."
  [port-number]
  (webserver/run-jetty
    welcome
    {:port (Integer. port-number)}))
```


## Configure the dev profile in your project

  When you start your Clojure webapp with `lein run` it looks for main class to run in the `:dev` profile first.  So we need to create a `:dev` profile.


  `:dev` profile that sets `-dev-main` to be the starting point of our application.  This

> ####Note::Add profile to project configuration
> Edit the `project.clj` and create a `:dev` profile to define the initial function to call when starting our webapp.

```clojure
:profiles {:dev
            {:main todo-list.core/-dev-main}}
```


The `project.clj` file should look like the following:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"

  :description "A Todo List server-side webapp using Ring & Compojure"
  :url "https://github.com/practicalli/clojure-todo-list-example"

  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}

  :dependencies [[org.clojure/clojure "1.10.1"]
                 [ring "1.8.0"]]

  :repl-options {:init-ns todo-list.core}

  :main todo-list.core

  :profiles {:dev
             {:main todo-list.core/-dev-main}})
```
