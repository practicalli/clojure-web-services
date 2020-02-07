![Practicalli Clojure Webapps book cover](/images/practicalli-clojure-webapps-book-cover.png)

> #### Hint::Book refresh in 2020
> The guides are to be updated to use Clojure CLI and tools.deps for project configuration and depenedency management.
> See [Clojure web server from scratch](https://practicalli.github.io/blog/posts/clojure-web-server-cli-tools-deps-edn/)
> and [Practicalli Clojure WebApps playlist](https://www.youtube.com/playlist?list=PLpr9V-R8ZxiCe9p9tFk24ChNSpGfanUbT) whilst this content is being updated.

## Introduction
A guide to developing server-side web applications and API's from the ground up using [Clojure](http://clojure.org), aiming for a simple and clean design using functional programming concepts. Libraries are used to provide common features and alternative libraries are discussed.

Relevant theory and background reading is included, however, the focus of this guide is for you to build these projects and experiment.

## Micro-frameworks approach
Clojure doesn't have frameworks like Rails or Spring for a very good reason.  There is no framework that is specific you the problem you are trying to solve.

Instead, the Clojure community has numerous libraries and blueprints that show how common services can be assembled.  These are often termed micro-frameworks (for want of a better name).  These micro-frameworks are templates with optional libraries, which you can customise to the specific needs of the problem you are solving.  More importantly, those libraries are relatively simple to replace with alternatives or your own libraries, to create an optomised solution.

Micro-frameworks typically have far less libraries that a framework, so are easier to learn.  You can also learn in stage as only a few core libraries and functions are needed to start with.

[![Join the conversation on Clojurians Slack](images/practicalli-slack-channel.png)](https://clojurians.slack.com/messages/practicalli)

Get a [free Clojurians slack community account](https://clojurians.net/)

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">Practicalli, Clojure WebApps</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://practicalli.github.io" property="cc:attributionName" rel="cc:attributionURL">Practicalli</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="https://practicalli.github.io/" rel="dct:source">practical.li</a>.
