# wrap-reload

 `wrap-reload` is a ring middleware function that will push all our code changes to the application each time we save.

![Ring - wrap-reload middleware](../images/clojure-ring-adaptor-middleware-handler-wrap-reload.png)


> ####Note::  Include wrap-reload in the namespace of our project
> Require the `wrap-reload` directly into the namespace

```clojure
(ns todo-list.core
  (:require [ring.adapter.jetty :as jetty]
            [ring.middleware.reload :refer [wrap-reload]]))
```

## Define a function to use wrap-reload

  We define a `-dev-main` function in our code and a `:dev` profile that sets `-dev-main` to be the starting point of our application.  This ensures we only use the `wrap-reload` function during development.

> ####Note:: Create a `-dev-main` function
> The `-dev-main` funciton is the same as `-main`, except we use the `wrap-reload` middleware around the `welcome` function.  Each time you change the `welcome` function definition it will be reloaded.
>
> The `wrap-realod` function needs the name of the function it should reload.  Using quote reader macro, **#'**, in front of the `welcome` function name tells Clojure to skip evaluation of the funciton and just use the name of the name instead.

```clojure
(defn -dev-main
  "A very simple web server using Ring & Jetty that reloads code changes via the development profile of Leiningen"
  [port-number]
  (jetty/run-jetty (wrap-reload #'welcome)
     {:port (Integer. port-number)}))
```

## Configure the dev profile in your project

  When you start your Clojure webapp with `lein run` it looks for main class to run in the `:dev` profile first.  So we need to create a `:dev` profile.

> ####Note::Add profile to project configuration
> Edit the `project.clj` and create a `:dev` profile to define the initial function to call when starting our webapp.

```clojure
:profiles {:dev
            {:main todo-list.core/-dev-main}}
```

---

Your `project.clj` file should look like the following:

```clojure
(defproject todo-list "0.1.0-SNAPSHOT"
  :description "A simple webapp using Ring"
  :url "http://example.com/FIXME"

  :license {:name "Creative Commons Attribution Share-Alike 4.0 International"
            :url  "https://creativecommons.org"}

  :dependencies
    [[org.clojure/clojure "1.10.0"]
     [ring                "1.7.1"]])

  :main todo-list.core

  :profiles {:dev
              {:main todo-list.core/-dev-main}})
```
