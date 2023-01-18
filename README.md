```none
██████╗ ██████╗  █████╗  ██████╗████████╗██╗ ██████╗ █████╗ ██╗     ██╗     ██╗
██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██║██╔════╝██╔══██╗██║     ██║     ██║
██████╔╝██████╔╝███████║██║        ██║   ██║██║     ███████║██║     ██║     ██║
██╔═══╝ ██╔══██╗██╔══██║██║        ██║   ██║██║     ██╔══██║██║     ██║     ██║
██║     ██║  ██║██║  ██║╚██████╗   ██║   ██║╚██████╗██║  ██║███████╗███████╗██║
╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝
```

## Book overview

A guide to developing server-side web services and API's from the ground up using [Clojure](http://clojure.org), aiming for a simple and clean design using functional programming concepts.

A REPL Driven development workflow provides a fast feedback loop, showing how the code works as its being written.

Relevant theory and background reading is included whilst keeping the practical focus of this guide on build projects and experimenting with the code.


## Book status
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/practicalli/clojure-web-services?style=for-the-badge)
[![Content ideas and other issues](https://img.shields.io/github/issues/practicalli/clojure-web-services?label=content%20ideas%20and%20issues&logoColor=green&style=for-the-badge)](https://github.com/practicalli/clojure-web-services/issues)
[![Pull requests](https://img.shields.io/github/issues-pr/practicalli/clojure-web-services?style=for-the-badge)](https://github.com/practicalli/clojure-web-services/pulls)
[![MegaLinter](https://github.com/practicalli/clojure-web-services/actions/workflows/megalinter.yaml/badge.svg)](https://github.com/practicalli/clojure-web-services/actions/workflows/megalinter.yaml)
[![Publish Book](https://github.com/practicalli/clojure-web-services/actions/workflows/publish-book.yaml/badge.svg)](https://github.com/practicalli/clojure-web-services/actions/workflows/publish-book.yaml)
[![MegaLinter](https://github.com/practicalli/clojure-web-services/actions/workflows/megalinter.yml/badge.svg)](https://github.com/practicalli/clojure-web-services/actions/workflows/megalinter.yml)


## License

<p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/">
<a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/sa.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"></a>
 <a property="dct:title" rel="cc:attributionURL" href="https://github.com/practicalli/clojure">Practicalli Clojure </a> by <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://practical.li">Practicalli</a> is licensed under <a href="http://creativecommons.org/licenses/by-sa/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">CC BY-SA 4.0 </a></p>


## Contributing

Issues and pull requests are most welcome.  Please detail issues as much as you can.  Pull requests are simpler to work with when they are specific to a page or at most a section.  The smaller the change the quicker it is to review and merge.

Please [see the detailed contributing section of the book](contributing.html) before raising an issue or pull request

* [Kanban board of issues](https://github.com/practicalli/clojure-web-services/projects/1)
* [Current Issues](https://github.com/practicalli/clojure-web-services/issues)
* [Current pull requests](https://github.com/practicalli/clojure-web-services/pulls)

[practicalli/clojure-deps-edn](https://github.com/practicalli/clojure-deps-edn) GitHub repository contains the Clojure CLI user level configuration used in this guide and issues and pull requests can also be made there.

By submitting content ideas and corrections you are agreeing they can be used in this workshop under the [Creative Commons Attribution ShareAlike 4.0 International license](https://creativecommons.org/licenses/by-sa/4.0/).  Attribution will be detailed via [GitHub contributors](https://github.com/practicalli/clojure-web-services/graphs/contributors).


## Sponsor Practicalli

[![Sponsor practicalli-john](https://raw.githubusercontent.com/practicalli/graphic-design/live/buttons/practicalli-github-sponsors-button.png)](https://github.com/sponsors/practicalli-john/)

The majority of my work is focused on the [Practicalli series of books and videos](https://practical.li/) and an advisory role with several communities

Thank you to [Cognitect](https://www.cognitect.com/), [Nubank](https://nubank.com.br/) and a wide range of other [sponsors](https://github.com/sponsors/practicalli-john#sponsors) for your continued support


## GitHub Actions

The megalinter GitHub actions will run when a pull request is created,checking basic markdown syntax.

A review of the change will be carried out by the Practicalli team and the PR merged if the change is acceptable.

The Publish Book GitHub action will run when PR's are merged into main (or the Practicalli team pushes changes to the default branch).


## Local development

Install mkdocs using the Operating system package manager

```bash
sudo apt install mkdocs
```

Or via Python pip

```bash
pip install mkdocs
```

Install the plugins used by the Practicalli site using Pip (these are also installed in the GitHub Action workflow)

```bash
pip install mkdocs-material mkdocs-callouts mkdocs-glightbox mkdocs-git-revision-date-localized-plugin pillow cairosvg mkdocs-redirects
```

> pillow and cairosvg python packages are required for [Social Cards](https://squidfunk.github.io/mkdocs-material/setup/setting-up-social-cards/)

Fork the practicalli/spacemacs GitHub repository and clone that fork to your computer,

```bash
git clone https://github.com/<your-github-account>/spacemacs.git

```

Run a local server from the root of the cloned project

```bash
mkdocs serve
```

The website will open at http://localhost:8000
