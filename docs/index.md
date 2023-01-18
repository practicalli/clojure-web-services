![Practicalli Clojure Web Services banner](https://raw.githubusercontent.com/practicalli/graphic-design/live/book-covers/practicalli-clojure-web-services-book-banner.png)

A guide to developing server-side web services and API's from the ground up using [Clojure](http://clojure.org), aiming for a simple and clean design using functional programming concepts.

A REPL Driven development workflow provides an instant feedback loop that shows how the code works as it is being written.

Relevant theory and background reading is included whilst keeping the practical focus of this guide on build projects and experimenting with the code.


## General approach

Projects are created and configure using Clojure CLI configuration.  Older content uses Leiningen for project configuration.

Larger projects use Integrant & Integrant REPL to manage components and state, using a reloaded REPL workflow to manage changes in addtion to evaluating functions in the REPL.

Persistence is provides via Postgresql (and eventually JUXT Crux)

tools.build will be used to create Clojure deployments, with GitHub actions and Docker used for Continuous Integration and orchestrating systems.

> ####WARNING::Heroku deployment to be archived
> Heroku Cloud service deployment approach is being archived as the service no longer provides a developer environment (November 2022)


## Library Composition approach

The Clojure community has a diverse set of libraries, each of which focuses on a specific need. These libraries are assembled to rapidly develop a tailored solution, avoiding bloat and unrequired complexity that comes with large frameworks.  

Libraries are relatively simple to replace with alternatives or used as inspiration for your own custom functions.

Templates create projects showing commonly used libraries along with example code. Templates demonstrate how common services can be assembled and how to use libraries together. Templates have options to configure the project as its created, customising to the specific needs of the problem being solved.
provide examples of libraries working together  

Frameworks are design decisions others have made and generalised to solve a range of problem, so there is no guarantee on how many of those decisions are relevant for the current project. Frameworks tend to include many features not relevant to the current problem, which can be challenging to remove or replace. Frameworks can be over relied upon, taking away an opportunity to think about the most relevant solution. Clojure does not focus on the classic framework approach like Rails or Spring, for a very good reason.


## Discussions and feedback

[![Practicalli channel on Clojurians Slack](images/practicalli-slack-channel.png)](https://clojurians.slack.com/messages/practicalli)

Get a [free Clojurians slack community account](https://clojurians.net/)


> #### NOTE::Book updated regularly
> Last published: {{ gitbook.time }}


## License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/">
<a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1">
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1">
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a>
 <a property="dct:title" rel="cc:attributionURL" href="https://github.com/practicalli/clojure-web-services">Practicalli Clojure Web Services</a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://practical.li">Practicalli</a> is licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0 </a></p>
