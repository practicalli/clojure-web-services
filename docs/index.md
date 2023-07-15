![Practicalli Clojure Web Services banner](https://raw.githubusercontent.com/practicalli/graphic-design/live/book-covers/practicalli-clojure-web-service-book-banner-light.png#only-light)
![Practicalli Clojure Web Services banner](https://raw.githubusercontent.com/practicalli/graphic-design/live/book-covers/practicalli-clojure-web-service-book-banner-dark.png#only-dark)

Develop server-side web services and API's from the ground up using [Clojure](http://clojure.org) following a simple and data-centric design and applying functional programming concepts.

Use a [REPL Workflow approach](introduction/repl-workflow.md) to provide instant feedback on the code behaviour as it is written, validating design decisions as they are made.

![Clojure REPL workflow](https://raw.githubusercontent.com/practicalli/graphic-design/live/clojure/clojure-repl-workflow-concept.png)


## Tools

Clojure CLI is used to manage library dependencies and run Clojure code, enhanced with [aliases from Practicalli Clojure CLI Config](https://practical.li/clojure/clojure-cli/practicalli-config/).

Larger projects use Integrant & Integrant REPL to manage components and state, using a reloaded REPL workflow to manage changes in addtion to evaluating functions in the REPL.

Persistence is provides via Postgresql (and eventually JUXT Crux)

tools.build will be used to create Clojure artefacts for deployment, with GitHub actions and Docker used for Continuous Integration and orchestrating systems.

make is a general build tool used to support project development and support automation of wokflow tasks.

??? WARNING "Heroku deployment to be archived"
    Heroku Cloud service deployment approach is being archived as the service no longer provides a developer environment (November 2022)

??? WARNING "Older content using Leiningen"
    Older content uses Leiningen for project configuration.  This content can be converted to a Clojure CLI project by creating a `deps.edn` file containing the relevant dependencies.  Add a `build.clj` configuration to create assets to deploy, e.g. jar & uberjar.


## Library Composition approach

The Clojure community provides a diverse set of libraries, each focused on a specific need. Libraries are assembled to rapidly develop a tailored solution, avoiding bloat and the unnecessary complexity that comes with large frameworks. Libraries are relatively simple to replace with alternatives or used as inspiration for your own custom functions.

Templates can be used to create example projects with common libraries, with code to show showing how libraries can be wired together.
provide examples of libraries working together.

??? INFO "Avoiding large frameworks"
    Frameworks are design decisions others have made and generalised to solve a range of problem, so there is no guarantee on how many of those decisions are relevant for the current project.

    Frameworks tend to include many features not relevant to the current problem, which can be challenging to remove or replace. Frameworks can be over relied upon, taking away an opportunity to think about the most relevant solution.

    Clojure does not focus on the classic framework approach like Rails or Spring, for this reason.


## Navigate the book

Use the mouse or built-in key bindings to navigate the pages of the book

- ++p++ , ++comma++ : go to previous page
- ++n++ , ++period++ : go to next page

Use the search box to quickly find a specific topic

- ++f++ , ++s++ , ++slash++ : open search dialog
- ++arrow-down++ , ++arrow-up++ : select next / previous result
- ++esc++ , ++tab++ : close search dialog
- ++enter++ : follow selected result


## Sponsor my work

[![Sponsor practicalli-john](https://raw.githubusercontent.com/practicalli/graphic-design/live/buttons/practicalli-github-sponsors-button.png){ align=left loading=lazy }](https://github.com/sponsors/practicalli-john/)

The majority of my work is now focused on the [Practicalli series of books and videos](https://practical.li/){target=_blank} and an advisory role with several communities

Thank you to [Cognitect](https://www.cognitect.com/){target=_blank}, [Nubank](https://nubank.com.br/){target=_blank} and a wide range of other [sponsors](https://github.com/sponsors/practicalli-john#sponsors){target=_blank} from the Clojure community for your continued support


## Creative commons license

<div style="width:95%; margin:auto;">
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a>
This work is licensed under a Creative Commons Attribution 4.0 ShareAlike License (including images & stylesheets).
</div>
