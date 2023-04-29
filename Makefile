# ------------------------------------------
# Makefile: Clojure Service
#
# Consistent set of targets to support local development of Clojure
# and build the Clojure service during CI deployment
#
# Requirements
# - cljstyle
# - Clojure CLI aliases
#   - `:env/dev` to include `dev` directory on class path
#   - `:env/test` to include `test` directory and libraries to support testing
#   - `:test/run` to run kaocha kaocha test runner and supporting paths and dependencies
#   - `:repl/rebel` to start a Rebel terminal UI
#   - `:package/uberjar` to create an uberjar for the service
# - docker
# - mega-linter-runner
#
# ------------------------------------------

# .PHONY: ensures target used rather than matching file name
# https://makefiletutorial.com/#phony
.PHONY: all clean docs lint pre-commit-check test


# ------- Makefile Variables --------- #

# run help if no target specified
.DEFAULT_GOAL := help

# Column the target description is printed from
HELP-DESCRIPTION-SPACING := 24

# Makefile file and directory name wildcard
# EDN-FILES := $(wildcard *.edn)

# ------------------------------------ #


# ------- Help ----------------------- #

# Source: https://nedbatchelder.com/blog/201804/makefile_help_target.html

help:  ## Describe available tasks in Makefile
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
	sort | \
	awk -F ':.*?## ' 'NF==2 {printf "\033[36m  %-$(HELP-DESCRIPTION-SPACING)s\033[0m %s\n", $$1, $$2}'

# ------------------------------------ #


# ------  Quality Checks  ------------ #

pre-commit-check: lint

lint:  ## Run MegaLinter with custom configuration (node.js required)
	$(info --------- MegaLinter Runner ---------)
	npx mega-linter-runner --flavor documentation --env "'MEGALINTER_CONFIG=.github/config/megalinter.yaml'" --remove-container

lint-fix:  ## Run MegaLinter with applied fixes and custom configuration (node.js required)
	$(info --------- MegaLinter Runner ---------)
	npx mega-linter-runner --fix --flavor documentation --env "'MEGALINTER_CONFIG=.github/config/megalinter.yaml'" --remove-container


lint-clean:  ## Clean MegaLinter report information
	$(info --------- MegaLinter Clean Reports ---------)
	- rm -rf ./megalinter-reports

# ------------------------------------ #


# --- Documentation Generation  ------ #

docs:  ## Build and run mkdocs in local server
	$(info --------- Mkdocs Local Server ---------)
	mkdocs serve --dev-addr localhost:7777

docs-changed:  ## Build only changed files and run mkdocs in local server
	$(info --------- Mkdocs Local Server ---------)
	mkdocs serve --dirtyreload --dev-addr localhost:7777

docs-build:  ## Build mkdocs
	$(info --------- Mkdocs Local Server ---------)
	mkdocs build

# ------------------------------------ #
