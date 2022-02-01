# Continuous Integration

To assist in the development of the application, CircleCI, a continuous integration service will be used.

Initially this will run all the unit tests for the application and report on the results.  In another chapter, CircleCI will be used to package the application and deploy the application.


## Alias for test runner

Edit `deps.edn` file and add an alias called `:test/run` that calls kaocha test runner on the code

  :test/run
  {:extra-paths ["test"]
   :extra-deps {lambdaisland/kaocha {:mvn/version "1.60.977"}}
   :main-opts   ["-m" "kaocha.runner"]
   :exec-fn kaocha.runner/exec-fn
   :exec-args {:randomize? false
               :fail-fast? true}}

Check the test runner is working by running the `clojure` command with the `:test/run` alias in a terminal at the root of the Clojure project

```bash
clojure -X:test/run
```


## Add CircleCI configuration

Edit `.circleci/config.yml` and add a configuration to build and test the Clojure application.  The `cimg/clojure:1.10.0` image contains OpenJDK 17 and the latest version of Clojure CLI, Leiningen and Babashka.

> Run the `clojure` commands in the root of the project before adding the configuration, to ensure the commands work locally first.


```yaml
version: 2.0
jobs:
  build:
    working_directory: ~/build
    docker:
      - image: cimg/clojure:1.10
    environment:
      JVM_OPTS: -Xmx3200m
    steps:
      - checkout
      - restore_cache:
          key: status-monitor-service-{{ checksum "deps.edn" }}
      - cache-dependencies
      - run: clojure -P
      - save_cache:
          paths:
            - ~/.m2
            - ~/.gitlibs
          key: status-monitor-service-{{ checksum "deps.edn" }}
      - Unit-testing
      - run: clojure -X:test/run
```


## Add project on CircleCI

Visit the CircleCI dashboard and select **Add Projects**.  Find the `status-monitor-service` repository and select **Set Up Project** button.

Choose the **Add Manual** install and **Start Building**

![CircleCI dashboard - status-monitor-service pipelines successful build](/images/circle-ci-status-monitor-pipelines-success.png)
