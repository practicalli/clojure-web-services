# Production Database - Heroku Postgres

![Heroku Postgres](/images/heroku-postgres-banner-simple.png)

Heroku provides a on-demand PostgreSQL service with very good support tooling.  The Hobby plan is free to use with a free Heroku account (no credit card needed).

PostgreSQL provides a production grade relational database with support for JSON an other common data types.  As its such a feature rich database

PostgreSQL instance runs outside the application code (unlike H2 database).

## Provision a database
Login to Heroku using your free account.

Two Heroku apps have already been created for the banking on Clojure project pipeline, staging and live, so a database should be provisioned for both apps.

![Clojure WebApps - Deployment - Heroku Pipeline for Banking on Clojure](/images/clojure-webapps-deployment-heroku-banking-on-clojure.png)

Select the staging app from the pipeline dashboard.

![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - details](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-details.png)

In the Overview section, click **Configure Add-ons**

![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - staging app overview](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-staging-app-overview.png)

Start typing Postgres in the Add-ons text box to see the matching add-ons available.  Select Heroku Postgres.


![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - staging app addon Heroku Postgres](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-staging-app-addon-heroku-postgres.png)

Select the Hobby plan in the pop-up window.  The Hobby plan is free and limited to 10,000 rows.  The plan can be upgraded ones the app starts making money (or funding is raised).

![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - staging app addon Heroku Postgres plan](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-staging-app-addon-heroku-postgres-plan.png)

The Postgres database is immediately provisioned and available for use.

![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - staging app addon Heroku Postgres provisioned](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-staging-app-addon-heroku-postgres-provisioned.png)


## Database Configuration on Heroku
Provisioning an Heroku postgres database adds a `DATABASE_URL` Config Var (Heroku Environment Variable) to the application the database is attached to.

In the Heroku dashboard, view the **Settings** and  select **Show Config Vars**

![Clojure WebApps - Deployment - Heroku Pipline for Banking on Clojure - staging app addon Heroku Postgres Config Vars](/images/clojure-webapps-deployment-heroku-banking-on-clojure-pipeline-staging-app-addon-heroku-postgres-config-vars.png)

Click on the pencil icon to see the full connection string, which takes the following form:

```
postgres://username:password@host:port/database-name
```

This is not a correct JDBC connection string, but it can be used to generate one.

## Generate the JDBC connection
Use the Heroku CLI tool to get the JDBC connection string for the database.

For the Banking on Clojure app, the following

```shell
heroku run echo \$JDBC_DATABASE_URL --app banking-on-clojure-staging
```

This returns the correct JDBC connection string in the form:

```
jdbc:postgresql://<hostname>:port/<database-name>?user=<username>&password=<password>&sslmode=require
```

This jdbc connection string is generated from the `DATABASE_URL` config var that is added to the heroku app when a database is provisioned.

> There are several applications attached to the Git repository, so its required to specify which application to run.
> The `run` command runs a container for the app, a Linux system that has the database attached.  Once the `echo` command is complete the container is shut down and discarded automatically.

<!-- Create a `DATABASE_URL` environment variable locally, either in your operating system or editor with the full connection string to allow testing of the database connection from a local development environment.  This is also useful when testing database schema migration scripts -->



## Viewing the database details on Heroku dashboard

> This will switch over to the data.heroku.com website, so you may be prompted to login again.

![Clojure WebApps - Databases - Heroku Postgres staging database](/images/clojure-webapps-deployment-heroku-banking-on-clojure-database-postgres-staging.png)


## Adding Postgresql driver to Clojure project
Add the [latest postgresql jdbc driver](https://jdbc.postgresql.org/) to the `deps.edn` file in the bankking on clojure project

```clojure
 :deps
 {org.clojure/clojure {:mvn/version "1.10.1"}

  ;; Web Application
  http-kit        {:mvn/version "2.3.0"}
  ring/ring-core  {:mvn/version "1.8.1"}
  ring/ring-devel {:mvn/version "1.8.1"}
  compojure       {:mvn/version "1.6.1"}
  hiccup          {:mvn/version "2.0.0-alpha2"}

  ;; Database
  seancorfield/next.jdbc    {:mvn/version "1.1.569"}
  com.h2database/h2         {:mvn/version "1.4.200"}
  org.postgresql/postgresql {:mvn/version "42.2.16"}}
```

> The Postgresql jdbc driver library will be used by next.jdbc


## Creating a staging data source
Add a `JDBC_DATABASE_URL` environment variable to hold the JDBC connection string to the Heroku database

```clojure
(def data-source-postgresql
    (jdbc/get-datasource (System/getenv "JDBC_DATABASE_URL")) )
```

Now the same SQL queries created for the H2 database can be tested on with PostgreSQL.

## Testing queries with PostgreSQL
In practice is seems there are noticeable differences between H2 and PostgreSQL, especially in terms of schema definitions.

For example, to create a table the table namespace should be supplied, in this case `public`.  The table creation syntax also as an IF clause, so if the database table already exists then the SQL statement does not try to create it and cause an error.

```clojure
(jdbc/execute!
    data-source-postgresql
    ["CREATE TABLE IF NOT EXISTS public.account_holder (
      user_id serial PRIMARY KEY,
      username VARCHAR ( 50 ) UNIQUE NOT NULL,
      password VARCHAR ( 50 ) NOT NULL,
      email VARCHAR ( 255 ) UNIQUE NOT NULL,
      created_on TIMESTAMP NOT NULL,
      last_login TIMESTAMP"])

```

The PostgreSQL syntax for creating tables is:

```
  CREATE TABLE [IF NOT EXISTS] table_name (
  column1 datatype(length) column_contraint,
  column2 datatype(length) column_contraint,
  column3 datatype(length) column_contraint,
  table_constraints);
```

> #### Hint::Use DBeaver to generate SQL
> [DBeaver](https://dbeaver.io/) is a free and comprehensive database tool that will generate SQL statements from database designs.


## Resources
* [Heroku Postgres Credentials](https://devcenter.heroku.com/articles/heroku-postgresql-credentials)
* [Heroku: Database Connection Pooling with Clojure](https://devcenter.heroku.com/articles/database-connection-pooling-with-clojure)
