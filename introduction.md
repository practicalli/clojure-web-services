![Practicalli Clojure Web Services banner](https://raw.githubusercontent.com/practicalli/graphic-design/live/book-covers/practicalli-clojure-web-services-book-banner.png)

A guide to developing server-side web services and API's from the ground up using [Clojure](http://clojure.org), aiming for a simple and clean design using functional programming concepts.

A REPL Driven development workflow provides a fast feedback loop, showing how the code works as its being written.

Relevant theory and background reading is included whilst keeping the practical focus of this guide on build projects and experimenting with the code.

## Clojure CLI and deps.edn
Projects are created and configure using Clojure CLI tools, using `deps.edn` for configuration.  Older content uses Leinigen for project configuration.

## Component / library approach
The Clojure community has a diverse set of libraries which focus on a specific need. These libraries are assembled to rapidly develop a tailored solution.  Using a library approach means those libraries are relatively simple to replace with alternatives or your own libraries.

Project templates are used to create projects that include commonly used libraries, along with example code, demonstrating how common services can be assembled. Templates have options to configure the project as its created, customising to the specific needs of the problem being solved.

Clojure does not focus on the classic framework approach like Rails or Spring, for a very good reason. Frameworks are design decisions others have made without knowing the context of the current problem at hand, so there is no guarantee on how many of those decisions are relevant. Frameworks tend to include many features not relevant to the current problem. Frameworks can be over relied upon, taking away an opportunity to think about the most relevant solution.

---

[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](https://practicalli.github.io/spacemacs/)


## Discussions and feedback
[![Join the conversation on Clojurians Slack](images/practicalli-slack-channel.png)](https://clojurians.slack.com/messages/practicalli)

Get a [free Clojurians slack community account](https://clojurians.net/)


## Creative commons license
<p xmlns:dct="http://purl.org/dc/terms/" xmlns:cc="http://creativecommons.org/ns#" class="license-text"><a rel="cc:attributionURL" href="https://practicalli.github.io/clojure-webapps/"><span rel="dct:title">Practicalli Clojure WebApps</span></a> by <a rel="cc:attributionURL" href="https://practicalli.github.io/"><span rel="cc:attributionName">Practicalli</span></a> Creative Commons Attribution Share-Alike 4.0 International<a href="https://creativecommons.org/licenses/by-sa/4.0"><img style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc_icon.svg" /><img  style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-by_icon.svg" /><img  style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-sa_icon.svg" /></a></p>
