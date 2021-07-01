# Summary

* [Introduction](introduction.md)
    * [Content Plan](content-plan.md)
    * [Requirements](requirements.md)
    <!-- * [Additional Resources](additional-resources.md) -->
    <!-- * [Theory: Clojure Overview](overview/index.md) -->
    * [Theory: WebApps in Clojure](overview/webapps-in-clojure.md)
<!-- * [Setup](setup/index.md) -->

## Clojure CLI Projects
* [Status Monitor - deps](projects/status-monitor-deps/index.md)
    * [Application server](projects/status-monitor-deps/application-server.md)
    * [Debug requests](projects/status-monitor-deps/debugging-requests.md)
    * [Unit Test & Mocking](projects/status-monitor-deps/unit-test-mocking-handlers.md)
    * [Defining handlers](projects/status-monitor-deps/refactor-handlers-and-tests.md)
    * [Continuous integration](projects/status-monitor-deps/continuous-integration.md)
    * [Deployment via CI](projects/status-monitor-deps/deployment-via-ci.md)

* [Banking on Clojure - deps](projects/banking-on-clojure/index.md)
    * [App Server Configuration](projects/banking-on-clojure/application-server-configuration.md)
    * [Refactor handlers](projects/banking-on-clojure/refactor-handler.md)
    * [Defining handlers](projects/banking-on-clojure/defining-handlers.md)
    * [Continous Integration](projects/banking-on-clojure/continuous-integration.md)
    * [Deployment Pipeline](projects/banking-on-clojure/deployment-pipeline.md)
    * [Deployment via CI to Heroku](projects/banking-on-clojure/deployment-via-ci.md)
    * [Unit Tests](projects/banking-on-clojure/unit-tests.md)
    * [Clojure Specs](projects/banking-on-clojure/spec-generative-testing.md)
    * [Development database](projects/banking-on-clojure/development-database.md)
    * [Instrument next.jdbc functions](projects/banking-on-clojure/instrument-next-jdbc-functions.md)
    * [Database tables](projects/banking-on-clojure/database-tables.md)
    * [Database queries](projects/banking-on-clojure/database-queries.md)
        * [Create Records](projects/banking-on-clojure/create-records.md)
        * [Read Records](projects/banking-on-clojure/read-records.md)
        * [Update Records](projects/banking-on-clojure/update-records.md)
        * [Delete Records](projects/banking-on-clojure/delete-records.md)
    * [Cyclic Load Dependency](projects/banking-on-clojure/cyclic-load-dependency.md)
    * [Spec: generate database data](projects/banking-on-clojure/clojure-spec-generate-mock-data.md)
    * [Unit Testing Database](projects/banking-on-clojure/unit-testing-the-database.md)
    <!-- * [Migratus](projects/banking-on-clojure/migratus.md) -->
    * [HoneySQL](projects/banking-on-clojure/honeysql.md)
    * [Namespace design](projects/banking-on-clojure/namespace-design.md)
    * [Production database](projects/banking-on-clojure/production-database.md)

## Architectural Components
* [Application servers](app-servers/index.md)
    * [Configuration](app-servers/basic-configuration.md)
        * [Java Properties](app-servers/java-system-properties.md)
    * [Simple restart](app-servers/simple-restart.md)
    * [Atom based restart](app-servers/atom-based-restart.md)
    <!-- * [Ring wrap-reload](app-servers/ring-wrap-reload.md) -->
    <!-- * [Component lifecycle](app-servers/component-lifecycle/index.md) -->
    <!--     * [mount](app-servers/component-lifecycle/mount.md) -->
    <!--     * [component](app-servers/component-lifecycle/component.md) -->
    <!--     * [integrant](app-servers/component-lifecycle/integrant.md) -->
    * [Logging](app-servers/app-server-logging.md)

* [Application logic](application-logic/index.md)
    * [Routing](application-logic/routing.md)
    <!-- * [Requests](application-logic/requests/index.md) -->
    <!-- * [Responses](application-logic/responses/index.md) -->
    <!-- * [handlers](application-logic/handlers/index.md) -->
    <!-- * [middleware](application-logic/middleware/index.md) -->
    <!-- * [Serving static content](app-servers/static-content.md) -->


* [Relational Database & SQL](relational-databases-and-sql/index.md)
    * [next.jdbc library](relational-databases-and-sql/next-jdbc-library/index.md)
    * [H2 Database](relational-databases-and-sql/h2-database/index.md)
        * [H2 schema design](relational-databases-and-sql/h2-database/schema-design.md)
        * [H2 database tools](relational-databases-and-sql/h2-database/database-tools.md)
    * [PostgreSQL Database](relational-databases-and-sql/postgresql-database.md)
        * [Managing Connections](relational-databases-and-sql/managing-connections.md)

<!-- * [Clojure databases](clojure-databases/index.md) -->
<!--     * [crux](clojure-databases/crux/index.md) -->

<!-- * [Key Value Store](key-value-store/index.md) -->
<!--     * [Redis](key-value-store/redis.md) -->


## Leiningen Projects

* [TODO WebApp](projects/leiningen/todo-app/index.md)
    * [Create a Project](projects/leiningen/todo-app/create-a-project/index.md)
        * [Update Project details](projects/leiningen/todo-app/create-a-project/update-project-details.md)
        <!-- * [Code so far](projects/leiningen/todo-app/create-a-project/code-so-far.md) -->
    * [Create a webserver with Ring](projects/leiningen/todo-app/create-a-webserver-with-ring/index.md)
        * [Add Ring Dependency](projects/leiningen/todo-app/create-a-webserver-with-ring/add-ring-dependency.md)
        * [Configure main namespace](projects/leiningen/todo-app/create-a-webserver-with-ring/configure-main-namespace.md)
        * [Theory: namespaces](projects/leiningen/todo-app/create-a-webserver-with-ring/namespaces.md)
        * [Include Ring Library](projects/leiningen/todo-app/create-a-webserver-with-ring/include-ring-library.md)
        * [Add a Jetty webserver](projects/leiningen/todo-app/create-a-webserver-with-ring/add-a-jetty-webserver.md)
        * [Theory: Coersing Types & java.lang](projects/leiningen/todo-app/create-a-webserver-with-ring/coersing-types-and-java-lang.md)
        * [Run webserver](projects/leiningen/todo-app/create-a-webserver-with-ring/run-webserver.md)
        <!-- * [Code so far](projects/leiningen/todo-app/create-a-webserver-with-ring/code-so-far.md) -->
    * [Theory: Introducing Ring](projects/leiningen/todo-app/introducing-ring/index.md)
    * [Create a handler function](projects/leiningen/todo-app/create-a-handler-function/index.md)
        * [Add error for bad routes](projects/leiningen/todo-app/create-a-handler-function/add-not-found.md)
        * [Theory: if function](projects/leiningen/todo-app/create-a-handler-function/if-function.md)
        * [Theory: maps and keywords](projects/leiningen/todo-app/create-a-handler-function/maps-and-keywords.md)
        <!-- * [Code so far](projects/leiningen/todo-app/create-a-handler-function/code-so-far.md) -->
    * [Unit test handler function](projects/leiningen/todo-app/unit-test-handler-function/index.md)
    * [Reloading the application](projects/leiningen/todo-app/reloading-the-application/index.md)
        * [Test your code reloads](projects/leiningen/todo-app/reloading-the-application/test-your-code-reloads.md)
        * [Middleware in Ring](projects/leiningen/todo-app/reloading-the-application/middleware.md)
        <!-- * [Code so far](projects/leiningen/todo-app/reloading-the-application/code-so-far.md) -->
    * [Compojure](projects/leiningen/todo-app/compojure/index.md)
        * [Theory: routing](projects/leiningen/todo-app/compojure/theory-routing.md)
        * [Adding dependency](projects/leiningen/todo-app/compojure/adding-dependency.md)
        * [Using Compojure](projects/leiningen/todo-app/compojure/using-compojure.md)
        * [Adding goodbye route](projects/leiningen/todo-app/compojure/adding-goodbye-route.md)
        * [About route](projects/leiningen/todo-app/compojure/about.md)
        * [Show request info](projects/leiningen/todo-app/compojure/show-request-info.md)
        * [Variable Path Elements](projects/leiningen/todo-app/compojure/variable-path-elements.md)
        * [Theory: local name bindings](projects/leiningen/todo-app/compojure/theory-local-name-bindings.md)
        * [Theory: using Clojure hash-maps](projects/leiningen/todo-app/compojure/theory-using-hash-maps.md)
        * [Lisp Calculator](projects/leiningen/todo-app/compojure/lisp-calculator.md)
        <!-- * [Code so far](projects/leiningen/todo-app/compojure/code-so-far.md) -->
    * [Deploying to Heroku](projects/leiningen/todo-app/heroku/index.md)
        * [Update the project](projects/leiningen/todo-app/heroku/update-project.md)
        * [Add Procfile](projects/leiningen/todo-app/heroku/procfile.md)
        * [Deploy to Heroku](projects/leiningen/todo-app/heroku/deploy.md)
        <!-- * [Code so far](projects/leiningen/todo-app/heroku/code-so-far.md) -->
    * [Hiccup HTML library](projects/leiningen/todo-app/hiccup/index.md)
        * [Updating handlers with hiccup](projects/leiningen/todo-app/hiccup/updating-handlers-with-hiccup.md)
        * [Create a new handler](projects/leiningen/todo-app/hiccup/create-new-handler.md)
        <!-- * [Code so far](projects/leiningen/todo-app/hiccup/code-so-far.md) -->
    * [Refactor namespace](projects/leiningen/todo-app/refactor-namespace/index.md)
        * [Base routes](projects/leiningen/todo-app/refactor-namespace/base-routes.md)
        <!-- * [Play routes](projects/leiningen/todo-app/refactor-namespace/play-routes.md) -->
        <!-- * [Task routes](projects/leiningen/todo-app/refactor-namespace/task-routes.md) -->
        * [Refactored Core](projects/leiningen/todo-app/refactor-namespace/core.md)
        <!-- * [Code so far](projects/leiningen/todo-app/refactor-namespace/code-so-far.md) -->
    * [Postgres Database](projects/leiningen/todo-app/postgres/index.md)
        * [Postgres install](projects/leiningen/todo-app/postgres/install.md)
        * [Environment Variables](projects/leiningen/todo-app/postgres/environment-variables.md)
        * [Postgres CLI](projects/leiningen/todo-app/postgres/postgres-cli.md)
        <!-- * [pgAdmin](projects/leiningen/todo-app/postgres/pg-admin.md) -->
        * [Dataclips](projects/leiningen/todo-app/postgres/dataclips.md)
        * [Connect to Postgres](projects/leiningen/todo-app/connect-to-postgres/index.md)
            * [Add Database Dependencies](projects/leiningen/todo-app/connect-to-postgres/add-database-dependencies.md)
            * [Define Database Connection](projects/leiningen/todo-app/connect-to-postgres/define-db-connection.md)
        * [Creating a database model](projects/leiningen/todo-app/database-model/index.md)
            * [Create table](projects/leiningen/todo-app/database-model/create-table.md)
            * [Create task](projects/leiningen/todo-app/database-model/create-task.md)
            * [List tasks](projects/leiningen/todo-app/database-model/show-all-task.md)
            * [Delete task](projects/leiningen/todo-app/database-model/delete-task.md)
            * [Alternative approaches](projects/leiningen/todo-app/database-model/alternative-approaches.md)
        * [Task handlers](projects/leiningen/todo-app/task-handlers/index.md)
            * [Add a task](projects/leiningen/todo-app/task-handlers/add-a-task.md)
            * [Show tasks](projects/leiningen/todo-app/task-handlers/show-task.md)
            * [Delete a task](projects/leiningen/todo-app/task-handlers/delete-a-task.md)
    <!-- * [A working example](projects/leiningen/todo-app/working-example/index.md) -->

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
* [Ring](reference/ring/index.md)
    * [request map](reference/ring/request-map.md)

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
