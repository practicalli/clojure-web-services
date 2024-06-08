# Deployment via Continuous Integration

Deployment will be via a workflow to the CircleCI configuration that deploys the application to a staging environment on successful completion of running all tests in the project.  Once the staging application is approved, the application build can be promoted to production.

![Deployment workflow](/images/circleci-workflow-sequential-git-heroku.png)

## Add Heroku orb to CircleCI configuration

Edit `.circleci/config.yml` and add the [heroku orb](https://circleci.com/orbs/registry/orb/circleci/heroku) and a workflow to Heroku.  The workflow has a dependency on the build job, so that will take place first.

The Heroku workflow will build the application from source code using the `heroku/deploy-via-git`.  Only changes pushed to the `live` branch of the GitHub repository will be used in the Heroku deploy workflow.

```yaml
version: 2.1  # circleci configuration version

orbs:
  kaocha: lambdaisland/kaocha@0.0.1 # Org settings > Security > uncertified orbs
  heroku: circleci/heroku@1.2.6 # Invoke the Heroku orb

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

jobs:    # basic units of work in a run
  build: # runs not using Workflows must have a `build` job as entry point
    working_directory: ~/build # directory where steps will run
    docker:                                                      # run the steps with Docker
      - image: circleci/clojure:openjdk-11-tools-deps-1.10.1.727 # image is primary container where `steps` are run
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

## Add depstar to build an uberjar

The depstar tool creates a Java archive (jar) package of the application.  The `deps.edn` configuration in the root of the project already contains an `uberjar` alias for this tool.

Check the project builds the uberjar locally:

```bash
clojure -X:project/uberjar
```

This will be the same command used in the build script


## Create a custom build behaviour
Heroku build scripts use Leiningen by default.  Configure Heroku to build with Clojure Tools, create a custom build file which will run instead of Leiningen.

Create a file called `bin/build` script in the root of the project

```bash
#!/usr/bin/env bash
clojure -X:project/uberjar
```

Create an empty `project.clj` file so that Heroku recognized the project as Clojure.


## Define how to run the application

Create a `Procfile` file in the root of the project directory containing the command to run the application.

Use the `$PORT` as an argument to the command.  Heroku automatically assigns a port number for an application to listen upon when creating a contain in which the application will run.  This port number is set using the `PORT` environment variable and is available to the application on startup.  Using the PORT environment variable ensures the Clojure application will receive requests.

```bash
web: java -jar banking-on-clojure.jar $PORT
```


## Specifying a Java version

Create a `system.properties` and specify the Java version to use for the application. Java 1.8 is the default version use on Heroku, however, our development environment is Java 11, so add a property to set the Java runtime to version 11.

```properties
java.runtime.version=17
```


## CircleCI Environment Variables
Open the CircleCI and select project settings > Environment Variables

Add environment variables to define where the Heroku application can be found and a token to provide access.

| Environment Variable | Value                                       |
|----------------------|---------------------------------------------|
| `HEROKU_API_KEY`     | name of the application created on Heroku   |
| `HEROKU_APP_NAME`    | API key found in Account Settings > API Key |


## Heroku Pipeline configuration

Login to the Heroku dashboard and create a new pipeline called `banking-on-clojure-webapp`

In the Heroku dashboard, open the application Settings and add a Config Vars using the name `CLOJURE_CLI_VERSION` with a value of `1.10.1.727`

![Heroku dashboard - Settings - Config Vars - Clojure CLI version](/images/heroku-dashboard-status-monitor-config-vars-clojure-cli-version.png)


Using Heroku Pipelines the staging environment is promoted to production rather than being rebuilt

![Heroku Pipeline concept - staging and production](https://raw.githubusercontent.com/jr0cket/developer-guides/master/heroku-pipelines-staging-production.png)

The Heroku dashboard can be used to promote the application into production, once the staging application is signed off.

![Heroku Pipeline banking-on-clojure](/images/heroku-pipeline-banking-on-clojure.png)


## Push changes to trigger build

Commit the changes and push them to the GitHub repository.

```bash
git push heroku live:main
```

> Heroku only deploys code pushed to the main (or master) branch of the remote. Pushing code to another branch of the heroku remote has no effect. Using the `live:local` form will push the local `live` branch to the remote `main` branch on Heroku.

This triggers a build by CircleCI.  The build downloads the dependencies and runs the unit tests.  If the tests pass, then the Heroku deploy workflow starts.

The two stages can be seen in the dashboard as the pipeline runs.

![CircleCI dashboard - status monitor service pipeline - build and deploy to Heroku](/images/circle-ci-status-monitor-pipelines-heroku-orb.png)

Now visit the deployed Heroku application to see it in action.


## Troubleshooting

If there are issues, then use the Heroku toolbelt to look at the logs.  In a command line terminal, issue the login command which opens a web browser to login to Heroku.  Once logged in, run the heroku logs command to view the latest logs

```bash
heroku login

heroku logs --app banking-on-clojure
```

The logs can also be viewed live, as the application is being deployed by including the `--tail` option when running the heroku logs command in a terminal

```bash
heroku logs --app banking-on-clojure --tail
```

The example Heroku logs show that the banking-on-clojure is using the default port number if non is supplied as an argument, rather than Heroku assigned port.  Heroku therefore considers the application as unresponsive and sets it status to crashed, tearing down the container the application is running in.

These logs were generated before adding the `$PORT` to the command in the `Procfile`.

![Heroku logs - status-monitor-service using incorrect port rather than Heroku assigned port so the application was considered unresponsive and crashed](/images/heroku-logs-status-monitor-process-crashed-wrong-port-number.png)


## No forced pushes

Heroku doesn't like force Git pushes coming via CircleCI.

![CircleCI Heroku orb no forced push](/images/circle-ci-heroku-orb-no-forced-push.png)

To get around this, either don't do force pushes to GitHub, or add the Heroku repository for the project as a remote to local git repository.

Heroku repository details in heroku dashboard **Settings** under **App Information**

Changes can now be pushed, ideally using `force-with-lease` to Heroku repository.


## Stopping the application

An application can be run for free on Heroku with the monthly free credits provided.  However, to make the most out of these free credits then applications not in use should be shut down

Run the following command in the root of the Clojure project.

```bash
heroku ps:stop banking-on-clojure
```
