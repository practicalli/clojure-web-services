# Continuous Integration with CirceCI
The application infrastructure has been established and now the main body of the development can commence.  Therefore it is very valuable to establish a continuous integration pipleline.

Practicalli Clojure: Continuous Integration with CircleCI](http://practicalli.github.io/clojure/testing/integration-testing/circle-ci/) covers in detail how to use Continuous Integration with Clojure projects (deps.edn and Leiningen).

## Using kaocha test runner
[LambdaIsland kaocha test runner](https://github.com/lambdaisland/kaocha) is used as the unit test runner as it will also run generative tests where functions have specifications defined.

Add a `:runner-kaocha` alias to the `deps.edn` file in the root of the project

```clojure
  :runner-kaocha
  {:extra-paths ["test"]
   :extra-deps  {lambdaisland/kaocha {:mvn/version "1.0-612"}}
   :main-opts   ["-m" "kaocha.runner"]}
```

Create the file `bin/kaocha` in the root of the project and make it executable (e.g. `chmod a+x bin/kaocha`)

```
#!/usr/bin/env bash

## Script to run the kaocha test runner
## for unit tests and clojure spec generative tests

clojure -A:test:runner-kaocha "$@"
```

## Configure CircleCI pipeline
Configure a pipleine to use a docker image with Java 11 and Clojure CLI tools 1.10.1.536.

The configuration uses the Kaocha Orb to simplify the configuration required to use the Kaocha test runner from within CircleCI.

A run step will call the kaocha script that is included in the project code repository and run the unit tests.  If function specifications are present in the project, generative tests will also be run.

```yaml
version: 2.1  # circleci configuration version

orbs:
  kaocha: lambdaisland/kaocha@0.0.1 # Org settings > Security > uncertified orbs

jobs:    # basic units of work in a run
  build: # runs not using Workflows must have a `build` job as entry point
    working_directory: ~/build # directory where steps will run
    docker:                                                      # run the steps with Docker
      - image: circleci/clojure:openjdk-11-tools-deps-1.10.1.536 # image is primary container where `steps` are run
    environment:            # environment variables for primary container
      JVM_OPTS: -Xmx3200m   # limit the maximum heap size to prevent out of memory errors
    steps:             # commands that comprise the `build` job
      - checkout       # check out source code to working directory
      - restore_cache: # restores saved cache if checksum hasn't changed since the last run
          key: banking-on-clojure-webapp-{{ checksum "deps.edn" }}
      - run: clojure -R:test:runner -Spath
      - save_cache:    # generate and store cache in the .m2 directory using a key template
          paths:
            - ~/.m2
            - ~/.gitlibs
          key: banking-on-clojure-webapp-{{ checksum "deps.edn" }}
      - run: bin/kaocha --reporter kaocha.report/documentation --no-randomize --no-color --plugin kaocha.plugin.alpha/spec-test-check
```


> #### Hint::Enable 3rd Party Orbs in Organisation > Security settings
