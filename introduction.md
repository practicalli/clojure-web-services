![Practicalli Clojure WebApps book banner](/images/practicalli-clojurewebapps-book-banner.png)

A guide to developing server-side web applications and API's from the ground up using [Clojure](http://clojure.org), aiming for a simple and clean design using functional programming concepts. Libraries are used to provide common features and alternative libraries are discussed.

Relevant theory and background reading is included, however, the focus of this guide is for you to build projects and experiment.

## Clojure CLI and deps.edn
Projects are created and configure using Clojure CLI tools, using `deps.edn` for configuration.  Older content uses Leinigen for project configuration.

## Component / library approach
The Clojure community has a diverse set of libraries which focus on a specific need. These libraries are assembled to rapidly develop a tailored solution.  Using a library approach means those libraries are relatively simple to replace with alternatives or your own libraries.

Project templates are used to create projects that include commonly used libraries, along with example code, demonstrating how common services can be assembled. Templates have options to configure the project as its created, customising to the specific needs of the problem being solved.

Clojure does not focus on the classic framework approach like Rails or Spring, for a very good reason. Frameworks are design decisions others have made without knowing the context of the current problem at hand, so there is no guarantee on how many of those decisions are relevant. Frameworks tend to include many features not relevant to the current problem. Frameworks can be over relied upon, taking away an opportunity to think about the most relevant solution.

[![Built with Spacemacs](https://cdn.rawgit.com/syl20bnr/spacemacs/442d025779da2f62fc86c2082703697714db6514/assets/spacemacs-badge.svg)](https://practicalli.github.io/spacemacs/)

> #### Hint::Book refresh in 2020
> The guides are to be updated to use Clojure CLI and tools.deps for project configuration and depenedency management.
> See [Clojure web server from scratch](https://practicalli.github.io/blog/posts/clojure-web-server-cli-tools-deps-edn/)
> and [Practicalli Clojure WebApps playlist](https://www.youtube.com/playlist?list=PLpr9V-R8ZxiCe9p9tFk24ChNSpGfanUbT) whilst this content is being updated.

## Discussions and feedback
[![Join the conversation on Clojurians Slack](images/practicalli-slack-channel.png)](https://clojurians.slack.com/messages/practicalli)

Get a [free Clojurians slack community account](https://clojurians.net/)


## Creative commons license
<p xmlns:dct="http://purl.org/dc/terms/" xmlns:cc="http://creativecommons.org/ns#" class="license-text"><a rel="cc:attributionURL" href="https://practicalli.github.io/clojure-webapps/"><span rel="dct:title">Practicalli Clojure WebApps</span></a> by <a rel="cc:attributionURL" href="https://practicalli.github.io/"><span rel="cc:attributionName">Practicalli</span></a> Creative Commons Attribution Share-Alike 4.0 International<a href="https://creativecommons.org/licenses/by-sa/4.0"><img style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc_icon.svg" /><img  style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-by_icon.svg" /><img  style="height:22px!important;margin-left: 3px;vertical-align:text-bottom;" src="https://search.creativecommons.org/static/img/cc-sa_icon.svg" /></a></p>
