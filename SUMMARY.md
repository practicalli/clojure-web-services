# Summary

* [Introduction](introduction.md)
    * [Content Plan](content-plan.md)
    * [Requirements](requirements.md)
    * [Additional Resources](additional-resources.md)
    * [Theory: Clojure Overview](overview/index.md)
    * [Theory: WebApps in Clojure](overview/webapps-in-clojure.md)
* [Setup](setup/index.md)

## Simple WebApps

* [ring & compojure with Leiningen](ring-compojure/create-a-project/index.md)
    * [Create a Project](ring-compojure/create-a-project/index.md)
        * [Update Project details](ring-compojure/create-a-project/update-project-details.md)
        * [Code so far](ring-compojure/create-a-project/code-so-far.md)
    * [Create a webserver with Ring](ring-compojure/create-a-webserver-with-ring/index.md)
        * [Add Ring Dependency](ring-compojure/create-a-webserver-with-ring/add-ring-dependency.md)
        * [Configure main namespace](ring-compojure/create-a-webserver-with-ring/configure-main-namespace.md)
        * [Theory: namespaces](ring-compojure/create-a-webserver-with-ring/namespaces.md)
        * [Include Ring Library](ring-compojure/create-a-webserver-with-ring/include-ring-library.md)
        * [Add a Jetty webserver](ring-compojure/create-a-webserver-with-ring/add-a-jetty-webserver.md)
        * [Theory: Coersing Types & java.lang](ring-compojure/create-a-webserver-with-ring/coersing-types-and-java-lang.md)
        * [Run webserver](ring-compojure/create-a-webserver-with-ring/run-webserver.md)
        * [Code so far](ring-compojure/create-a-webserver-with-ring/code-so-far.md)
    * [Theory: Introducing Ring](ring-compojure/introducing-ring/index.md)
    * [Create a handler function](ring-compojure/create-a-handler-function/index.md)
        * [Add error for bad routes](ring-compojure/create-a-handler-function/add-not-found.md)
        * [Theory: if function](ring-compojure/create-a-handler-function/if-function.md)
        * [Theory: maps and keywords](ring-compojure/create-a-handler-function/maps-and-keywords.md)
        * [Code so far](ring-compojure/create-a-handler-function/code-so-far.md)
    * [Unit test handler function](ring-compojure/unit-test-handler-function/index.md)
    * [Reloading the application](ring-compojure/reloading-the-application/index.md)
        * [Test your code reloads](ring-compojure/reloading-the-application/test-your-code-reloads.md)
        * [Middleware in Ring](ring-compojure/reloading-the-application/middleware.md)
        * [Code so far](ring-compojure/reloading-the-application/code-so-far.md)
    * [Compojure](ring-compojure/compojure/index.md)
        * [Theory: routing](ring-compojure/compojure/theory-routing.md)
        * [Adding dependency](ring-compojure/compojure/adding-dependency.md)
        * [Using Compojure](ring-compojure/compojure/using-compojure.md)
        * [Adding goodbye route](ring-compojure/compojure/adding-goodbye-route.md)
        * [About route](ring-compojure/compojure/about.md)
        * [Show request info](ring-compojure/compojure/show-request-info.md)
        * [Variable Path Elements](ring-compojure/compojure/variable-path-elements.md)
        * [Theory: local name bindings](ring-compojure/compojure/theory-local-name-bindings.md)
        * [Theory: using Clojure hash-maps](ring-compojure/compojure/theory-using-hash-maps.md)
        * [Lisp Calculator](ring-compojure/compojure/lisp-calculator.md)
        * [Code so far](ring-compojure/compojure/code-so-far.md)

## Deployment
* [Deploying to Heroku](heroku/index.md)
    * [Update the project](heroku/update-project.md)
    * [Add Procfile](heroku/procfile.md)
    * [Deploy to Heroku](heroku/deploy.md)
    * [Code so far](heroku/code-so-far.md)

## Generating HTML and SVG
* [Hiccup HTML library](hiccup/index.md)
    * [Updating handlers with hiccup](hiccup/updating-handlers-with-hiccup.md)
    * [Create a new handler](hiccup/create-new-handler.md)
    * [Code so far](hiccup/code-so-far.md)
    * [Refactor namespace](refactor-namespace/index.md)
    * [Base routes](refactor-namespace/base-routes.md)
    * [Play routes](refactor-namespace/play-routes.md)
    * [Task routes](refactor-namespace/task-routes.md)
    * [Refactored Core](refactor-namespace/core.md)
    * [Code so far](refactor-namespace/code-so-far.md)

## Database backed WebApps
* [PostgreSQL and JDBC](postgres/index.md)
    * [Postgres Database](postgres/index.md)
        * [Postgres install](postgres/install.md)
        * [Environment Variables](postgres/environment-variables.md)
        * [Postgres CLI](postgres/postgres-cli.md)
        * [pgAdmin](postgres/pg-admin.md)
        * [Dataclips](postgres/dataclips.md)
    * [Connect to Postgres](connect-to-postgres/index.md)
        * [Add Database Dependencies](connect-to-postgres/add-database-dependencies.md)
        * [Define Database Connection](connect-to-postgres/define-db-connection.md)
    * [Creating a database model](database-model/index.md)
        * [Create table](database-model/create-table.md)
        * [Create task](database-model/create-task.md)
        * [List tasks](database-model/show-all-task.md)
        * [Delete task](database-model/delete-task.md)
        * [Alternative approaches](database-model/alternative-approaches.md)
    * [Task handlers](task-handlers/index.md)
        * [Add a task](task-handlers/add-a-task.md)
        * [Show tasks](task-handlers/show-task.md)
        * [Delete a task](task-handlers/delete-a-task.md)
    * [A working example](working-example/index.md)

## Building API's
* [Server-side API](server-side-api/index.md)
    * [Compojure-API template](server-side-api/compojure-api-template.md)
    * [Create API project](server-side-api/create-compojure-api-project.md)
    * [Swagger](server-side-api/swagger.md)
        * [ring-swagger](server-side-api/ring-swagger.md)
    * [Plumatic Schema](server-side-api/plumatic-schema.md)
    * [JSON files](server-side-api/json-files.md)
    * [Testing an API](server-side-api/testing-api.md)
        * [ring-mock library](server-side-api/ring-mock.md)
        *   [cheshire library](server-side-api/cheshire.md)
    * [End to End Testing](server-side-api/end-to-end-testing/index.md)
        * [Swagger](server-side-api/end-to-end-testing/swagger.md)
        * [Curl](server-side-api/end-to-end-testing/curl.md)
        * [Insomnia](server-side-api/end-to-end-testing/insomnia.md)
        * [Postman Client](server-side-api/end-to-end-testing/postman.md)
    * [Terminology](server-side-api/terminology.md)
    * [Project: Game Scoreboard](server-side-api/projects/game-scoreboard/index.md)
    * [Defining scoreboard](server-side-api/projects/game-scoreboard/defining-scoreboard.md)
    * [Defining Players](server-side-api/projects/game-scoreboard/defining-scores.md)
    * [Game Scoreboard UI](server-side-api/projects/game-scoreboard-ui/index.md)

<!-- ## Micro-frameworks (TODO) -->

<!-- * [Overview](micro-framework/index.md) -->
<!--     * [Luminus](micro-framework/luminus/index.md) -->
<!--     * [Pedestal](micro-framework/pedestal/index.md) -->
<!--     * [Edge](micro-framework/edge/index.md) -->


## Reference
* [Theory: Persistent Data Structures](persistent-data-structures/index.md)
    * [Theory: Lists](persistent-data-structures/lists.md)
    * [Theory: Maps](persistent-data-structures/maps.md)
    * [Theory: Vectors](persistent-data-structures/vectors.md)
    * [Theory: Sets](persistent-data-structures/sets.md)
<!-- * [Compojure defroutes macro](compojure/defroutes.md) -->

## Hacking on content
<!-- * [Variable tag names](work-in-progress.md) -->
    <!-- * [Using Postgres from Clojure](using-postgres/index.md) -->
* [Project: URL Shortner as a Service](project-url-shortner/index.md)
    * [Create project](project-url-shortner/create-project.md)
    * [Run project](project-url-shortner/run-project.md)
    * [Test app reloading](project-url-shortner/test-app-reloading.md)
    * [Compojure Template](project-url-shortner/compojure-template.md)
    * [Design data structure](project-url-shortner/design-data-structure.md)
    * [Whats in a request](project-url-shortner/whats-in-a-request.md)
    * [Redirect to full URL](project-url-shortner/redirect-to-full-url.md)
    <!--     * [Add static resources](project-url-shortner/add-static-resources.md) -->
    <!--     * [Disable anti-forgery check](project-url-shortner/disable-anti-forgery-check.    md) -->
    <!--     * [Create HTML Form](project-url-shortner/create-html-form.md) -->
    <!--     * [Using Ring Redirect](project-url-shortner/using-ring-redirect.md) -->
    <!--     * [Named alias handler](project-url-shortner/named-alias-handler.md) -->
    <!--     * [if-let function](project-url-shortner/if-let-function.md) -->
    <!--     * [Refactor: Hiccup form](project-url-shortner/refacor-hiccup-form.md) -->
    <!--     * [Alias generator](project-url-shortner/alias-generator.md) -->
    <!--     * [Persist aliases](project-url-shortner/persist-aliases.md) -->
    <!--     * [Postgres setup](project-url-shortner/postgres-setup.md) -->
    <!--     * [Redis setup](project-url-shortner/redis-setup.md) -->
    <!--     * [create database](project-url-shortner/create-database.md) -->
    <!--     * [add alias to database](project-url-shortner/add-alias-to-database.md) -->
    <!--     * [get alias from database](project-url-shortner/get-alias-from-database.md) -->
    <!--     * [delete alias from database](project-url-shortner/delete-alias-from-database.md) -->
    <!-- * [Building a full database backed app](full-app/index.md) -->
    <!-- * [Testing](testing/index.md) -->
    <!--     * [Unit Testing](testing/unit/testing/index.md) -->
    <!-- * [Reference](reference/index.md) -->
    <!-- * [Lighttable](lighttable/index.md) -->
    <!--     * [Configure Keyboard mappings](lighttable/configure-keyboard-mappings.md) -->
    <!-- * [Projects with Leiningen](leiningen/index.md) -->
    <!--     * [Create a project](leiningen/create-a-project.md) -->
    <!--     * [Run the REPL](leiningen/run-the-repl.md) -->
    <!--     * [Profiles overview](leiningen/profile.md) -->
    <!--     * [Adding a dev profile](leiningen/adding-a-dev-profile.md) -->
    <!--     * [Templates](leiningen/templates.md) -->
    <!--     * [Plugins](leiningen/plugins.md) -->
    <!-- * [Development Environments](development-environment/index.md) -->
    <!--     * [Java](development-environment/java.md) -->
    <!--     * [Leiningen](development-environment/leiningen.md) -->
    <!--     * [LightTable](development-environment/lighttable.md) -->
    <!--     * [Other tools](development-environment/other-tools.md) -->
