# Clojure Overview

> ####Info::I love Clojure because its powerful, flexible and fun.

## Clojure is

* a **general purpose language** that compiles code that runs on the Java Virtual Machine (JVM).
* a **functional programming language** with a data centric approach (mostly pure)
* a **very small syntax** (12 primitives, 4 of which were added for Java interoperability)
* a **dynamically & strongly typed** with type inference, keeping the language simple
* a **fast-feedback** approach for development, helping you quickly explore a problem domain
* a modern implementation of **LISP**
* a highly extensible language via **macros**
* an efficient way to manage state changes via **persistent data structures** & **software transactional memory**

> ####Hint::Avoiding state changes
> In functional programming we avoid changing state as much as possible.
>
> If a function does not change state it is referentially transparent, always returning the same result when given the same input (arguments).  These are refered to as Pure Functions.  Pure functions are highly modular as they do not affect any other part of the system and do not require complex threading for scalability.


## ClojureScript

[ClojureScript](https://github.com/clojure/clojurescript) is Clojure that compiles to to JavaScript and runs in the browser (JavaScript Engine).  Most of the code and libraries available for Clojure works seamlessly when compiled to JavaScript.

ClojureScript is based heavily on the work done for Google Closures and there is a strong focus on Reactive client side apps.

There is a common file extension, `.cljc` that signifies Clojure code that is written to run on the JVM and JavaScript engines.


## Clojure Community

There is a vibrant and highly active community around Clojure.  In London alone there is a regular monthly talk and 4 coding dojo every month.

## Community resources

[Clojure. tv](https://www.youtube.com/channel/UCaLlzGqiPE2QRj6sSOawJRg) and [Planet Clojure](http://planet.clojure.in/) are the tip of the iceburg to a large amount of Clojure resources available via the Internet.
