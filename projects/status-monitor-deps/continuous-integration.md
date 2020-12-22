# Continuous Integration
To assist in the development of the application, CircleCI, a continuous integration service will be used.

Initially this will run all the unit tests for the application and report on the results.  In another chapter, CircleCI will be used to package the application and deploy the application.


## Add CircleCI configuration
Edit `.circleci/config.yml` and add a configuration to build and test the Clojure application.  The configuration uses a docker image with OpenJDK 11 and the latest Clojure CLI tools.

> Run the `clojure` commands in the root of the project before adding the configuration, to ensure the commands work locally first.


```yaml
version: 2.0
jobs:
  build:
    working_directory: ~/build
    docker:
      - image: circleci/clojure:openjdk-11-tools-deps-1.10.1.727
    environment:
      JVM_OPTS: -Xmx3200m
    steps:
      - checkout
      - restore_cache:
          key: status-monitor-service-{{ checksum "deps.edn" }}
      - run: clojure -R:dev:test:runner -Spath
      - save_cache:
          paths:
            - ~/.m2
            - ~/.gitlibs
          key: status-monitor-service-{{ checksum "deps.edn" }}
      - run: clojure -A:dev:test:runner
```


## Add project on CircleCI
Visit the CircleCI dashboard and select **Add Projects**.  Find the `status-monitor-service` repository and select **Set Up Project** button.

Choose the **Add Manual** install and **Start Building**

![CircleCI dashboard - status-monitor-service pipelines successful build](/images/circle-ci-status-monitor-pipelines-success.png)
