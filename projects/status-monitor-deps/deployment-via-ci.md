# Deployment Via Continuous Integration
Building on the CircleCI build pipleine created so far, the application will be deployed on Heroku if all the tests pass.  A [workflow](https://circleci.com/docs/2.0/workflows/) is added to the CircleCI configuration that [deploys the application on Heroku from the source code](https://circleci.com/docs/2.0/deployment-integrations/#heroku).  Heroku packages the application into an uberjar and then runs the application from that uberjar.

[![CircleCI workflow concept image - stages](/images/circleci-workflow-sequential-git-heroku.png)](https://circleci.com/docs/2.0/workflows/)

When commits in the Clojure project code are pushed to GitHub they are detected by CircleCI and the tests run.  If the tests pass then the Heroku deployment stage starts.

## Add depstar to buld an uberjar
Use the depstar tool to create a Java archive (jar) package of the application.  The `deps.edn` configuration in the root of the project already contains an `uberjar` alias for this tool.

```clojure
  :uberjar
  {:extra-deps {seancorfield/depstar {:mvn/version "1.0.94"}}
   :main-opts  ["-m" "hf.depstar.uberjar" "status-monitor-service.jar"
                "-C" "-m" "practicalli.status-monitor-service"]}
```

To try this on the command line:

```shell
clojure -A:uberjar
```

This will be the same command used in the build script


## Create a custom build behaviour
Heroku build scripts use Leiningen by default.  Configure Heroku to build with Clojure Tools, create a custom build file which will run instead of Leiningen.

Create a file called `bin/build` script in the root of the project

```shell
#!/usr/bin/env bash
clojure -A:uberjar
```

Create an empty `project.clj` file so that Heroku recognized the project as Clojure.


## Define how to run the application
Create a `Procfile` file in the root of the project directory containing the command to run the application.

Use the `$PORT` as an argument to the command.  Heroku automatically asignes a port number for an application to listen upon when creating a contain in which the application will run.  This port number is set using the `PORT` environment variable and is available to the application on startup.  Using the PORT environment variable ensures the Clojure application will recieve requests.

```
web: java -jar status-monitor-service.jar $PORT
```


## Specifying a Java version
Create a `system.properties` and specify the Java version to use for the application. Java 1.8 is the default version use on Heroku, however, our development environment is Java 11, so add a property to set the Java runtime to version 11.

```
java.runtime.version=11
```


## Heroku configuration
Login to the Heroku dashboard and create a new application.

In the Heroku dashboard, open the application Settings and add a Config Vars using the name `CLOJURE_CLI_VERSION` with a value of `1.10.1.727`

![Heroku dashboard - Settings - Config Vars - Clojure CLI version](/images/heroku-dashboard-status-monitor-config-vars-clojure-cli-version.png)


## CircleCI configuration with Heroku Orb
Edit the `.circleci/config.xml` file and add the [heroku orb](https://circleci.com/orbs/registry/orb/circleci/heroku) and a workflow to call the orb task.  The workflow has a dependency on the build job, so that will take place first.

The Heroku workflow will build the application from source code using the `heroku/deploy-via-git`.  Only changes pushed to the `live` branch of the GitHub repository will be used in the Heroku deploy workflow.

> If feature branches are useful to deploy on Heroku, additional Heroku applications can be created and pushed to directly from the local Git repository

```
version: 2.1

orbs:
  heroku: circleci/heroku@0.0.10. # Invoke the Heroku orb

workflows:
  heroku_deploy:
    jobs:
      - build
      - heroku/deploy-via-git: # Use the pre-configured job, deploy-via-git
          requires:
            - build
          filters:
            branches:
              only: live

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



## CircleCI Environment Variables
Open the CircleCI and select project settings > Environment Variables

Add environment variables to define where the Heroku application can be found and a token to provide access.

| Environment Variable  | Value                                       |
|-----------------------|---------------------------------------------|
| HEROKU_API_KEY        | name of the application created on Heroku   |
| HEROKU_APP_NAME       | API key found in Account Settings > API Key |


## Push changes to trigger build
Commit the changed and push them to the GitHub repository.  This triggers a build by CircleCI.  The build downloads the dependencies and runs the unit tests.  If the tests pass, then the Heroku deploy workflow starts.

The two stages can be seen in the dashboard as the pipeline runs.

![CircleCI dashboard - status monitor service pipeline - build and deploy to Heroku](/images/circle-ci-status-monitor-pipelines-heroku-orb.png)


Now visit the deployed Heroku application to see it in action.


## Troubleshooting
If there are issues, then use the Heroku toolbelt to look at the logs.  In a command line terminal, issue the login command which opens a web browser to login to Heroku.  Once logged in, run the heroku logs command to view the latest logs

```shell
heroku login

heroku logs --app status-monitor-service
```

The logs can also be viewed live, as the application is being deployed by including the `--tail` option when running the heroku logs command in a terminal

```
heroku logs --app status-monitor-service --tail
```


The example Heroku logs show that the status-monitor-service is using the default port number if non is supplied as an argument, rather than Heroku assigned port.  Heroku therefore considers the application as unresponsive and sets it status to crashed, tearing down the container the application is running in.

These logs were generated before adding the `$PORT` to the command in the Procfile.

![Heroku logs - status-monitor-service using incorrect port rather than Heroku assigned port so the application was considered unresponsive and crashed](/images/heroku-logs-status-monitor-process-crashed-wrong-port-number.png)


## No forced pushes
Heroku doesnt like force Git pushes coming via CircleCI.

![CircleCI Heroku orb no forced push](/images/circle-ci-heroku-orb-no-forced-push.png)

To get around this, either dont do force pushes to GitHub, or add the Heroku repositor for the project as a remote to local git repository.

Heroku repository details in heroku dashboard **Settings** under **App Information**

Changes can now be pushed, ideally using `force-with-lease` to Heroku repository.

`git push heroku live:master`

> Heroku only builds from a branch called master, so the above command pushes the local `live` branch to the remote `master` branch on Heroku.


## Stopping the application
An application can be run for free on Heroku with the monthly free credits provided.  However, to make the most out of these free credits then applications not in use should be shut down

Run the following command in the root of the Clojure project.

```shell
heroku ps:stop status-monitor-service
```
