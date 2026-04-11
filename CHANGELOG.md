# Changelog

## Unreleased

- dev: update GitHub actions via `make dependencies-update`

| :file                       | :name                         | :current | :latest |
|-----------------------------|-------------------------------|----------|---------|
| .github/workflows/docs.yaml | actions/checkout              | v5       | v6.0.2  |
|                             | actions/configure-pages       | v5       | v6      |
|                             | actions/deploy-pages          | v4       | v5      |
|                             | actions/setup-python          | v5       | v6.2.0  |
|                             | actions/upload-pages-artifact | v4       | v5.0.0  |


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
