# Changelog

## Unreleased

### Changed

- build(make): 🔧 `deps-update` & `deps-upgrade` tasks
- ci(zensical): 📦 update setup-uv action to v10.2.0
- build(make): `git-rebase`, `git-sr` tasks for mgitstatus
- build(mkdocs): ♻️ refactor navigation for migration to zensical
- build(zensical): ♻️ refactor overrides for zensical migration
- build(zensical): 🔧 migrate to zensical configuration
- build(make): 🔧 add `docs-clean` task to delete build artifacts
- docs(intro): ✏️ add warning about rewrite of project guides
- build(zensical): ♻️ refactor building-api testing page and section
- docs(building-api): ✏️ rework section introduction page
- build(zensical): ♻️ move compojure api pages to reference section
- docs(readme): ✏️ update megalinter and publish book status badges
- docs(projects): ✏️ add refactor warning for section
- docs(api): ♻️ reword and update reitit overview


## 2026-08-22

### Added

- build(marksman): 🔧 set docs as root directory for all links
- docs(links): ✏️ update links reported as missing pages

### Changed

- ci(github): 📦 update GitHub actions via `make dependencies-update`
- build(make): 🔧 practicalli task definitions for zensical project
- build(make): 🔧 task to install zensical with UV
- build(zensical): 💄 update overrides to zensical
- build(zensical): 💄 automatic light dark color scheme
- ci(zensical): 🔧 practicalli workflows for zensical static site generator
- ci(zensical): run zensical build via uvx
- refactor(projects): 🔥 remove leiningen based projects

# 2026-04-11

- dev: spell lychee & repository trufflehog linters warn only (false positives)
- dev: action/checkout v4 with sparse-checkout for megalinter
- dev: sparse-checkout for publish-book workflow
- dev: action/checkout v4 with sparse-checkout for changelog checker workflow
- mkdocs: update emoji extension name for material 9.4 and update readme

### Added
- building-api: add reitit overview and quick intro
- dev: Makefile using Practicalli task definitions for books

### Changed
- nav: refactor server-side-api to building-api

* 2023-03-10
### Added
- started a changelog
### Changed
- [#90](https://github.com/practicalli/clojurescript/issues/90) convert ClojureScript book to MkDocs
- Update figwheel logo name
- Update ClojureScript REPL workflow image
