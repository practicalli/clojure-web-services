# CI: Heroku

Heroku is a now only a commercial service without a developer environment.

Practicalli is looking into other services as that are more developer friendly.


## Heroku pipelines

Using Heroku Pipelines the staging environment is promoted to production rather than being rebuilt

![Heroku Pipeline concept - staging and production](https://raw.githubusercontent.com/jr0cket/developer-guides/master/heroku-pipelines-staging-production.png)

The Heroku dashboard can be used to promote the application into production, once the staging application is signed off.

![Heroku Pipeline banking-on-clojure](https://raw.githubusercontent.com/practicalli/graphic-design/live/continuous-integration/heroku/heroku-pipeline-banking-on-clojure.png)


## Heroku Build process

The build process starts when commits are pushed to Heroku, either directly or via a continuous integration service (eg. CircleCI).

[![Heroku build process](https://raw.githubusercontent.com/jr0cket/developer-guides/gh-pages/heroku-deployment-process-simplified.png)](https://raw.githubusercontent.com/jr0cket/developer-guides/gh-pages/heroku-deployment-process-simplified.png)
