# Features of Clojure 

## Dynamic Development

  Clojure has a REPL, its run-time environment.  You can define functions and data structures on th fly, change code and re-evaluate it whilst your application is still running.
  
  You could even connect to the REPL of a live system and change its behaviour without any down time (unless of course you write code that crashes).

##  Dynamically Typed

Clojure selects the most appropriate types for values when they are evaluated, so you dont need to specify types up front.  This keeps your code very concise.

You can specify a type if required and this is not uncommon when calling Java Libraries from Clojure, eg. you can use Integer to specify you want a number as an integer rather than a string.

## Functional Programming

  Functions return a value (even if that value is nil) and you can therefore use a function as an agument to another function.  This is termed as _first order_ functions.

## Lisp

  Everything is a list, yes everything, even those things that dont look like a list are a list underneath.  
  
  Lists are executable.  The open Parentesis `(` denote that the next thing is the name of a function to be called.  The behaviour of `(` can be over-ridden using `quote` or its short form `'` and the list is treated only as data.

## Runtime Polymorphism

  See Clojure arity and multi-methods

## Concurrent Programming

  Thread'ed code is much safe when you dont change state (eg. immutable state).  Clojure is stateless by default.
  
  Clojure helps you scale your applications by with a parrallel procssing approach, as you can run functions over immutable datastructures without conflict.

## Hosted on the JVM

  Clojure has great Java Interoperability.  It can be nicer to work with Java libraries in Clojure that it can in Java (eg. Swing)




## Clojure characteristics in more detail



* REPL - Dynamic runtime - you can define  code in small pieces (expressions), getting immediate feedback by evaluating that code or re-evaluating code you have redefined.  Clojure is continually compiled to Java bytecode in the background, so no waiting for that pesky compile cycle to finish.  This makes the REPL a fast way to explore your problem domain with code

* Functional programming - all functions evaluate to a value, so can be used as arguments (parameters) to other functions.

* Persistent data structures at its core (list, vector, map, set). Everything is immutable by default, except the names you give to your functions & data structures.  Rather than changing a data structure, Clojure instead creates a new data structure that contains the changes and copies of the existing data.

* Managed state changes in Software Transactional Memory - automatic management of state changes via Software transactional memory - like having an ACID database in memory, managing requests to change values over time.


* A modern LISP - leaner syntax and not as many brackets as LISP

* Highly extensible via Macros - much of Clojure is built using macros to build on a small number of primative functions.  Anyone can create their own macro, which esentially provides an easier way of expressing yourself in code.  A macro is like a template that takes in source code and returns the expanded source code back to Clojure, replacing the macro code.  Macros therefore help to remove repetition and boilerplate code from the Clojure language.


## Constraints

Clojure relies on the JVM so there can be a slightly longer boot time than a scripting language like Javascript.  However, as you can connect to the Clojure runtime (the REPL) of a live system and because Clojure is dynamic, you can make changes to that live system without any downtime.  



