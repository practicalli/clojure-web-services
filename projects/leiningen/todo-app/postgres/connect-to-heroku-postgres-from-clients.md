# Connecting to Heroku Postgres from Postgres Clients

* Command Line
* GUI tools
* Operations tools

Heroku Postgres databases are accessible from anywhere via a secure http connection, so you can connect your favourite Postgres client.

## View Provisioned Postgres Data stores

Login to https://data.heroku.com/ to see all the provisioned Heroku Postgres data stores (postgres, redis, etc.) and data clips.

![Heroku Data Dashboard - data stores](https://raw.githubusercontent.com/practicalli/graphic-design/live/heroku/screenshots/heroku-data-dashboard-datastores.png)

## View Datastore add-on

Login to https://heroku.com/ to see the dashboard of Heroku Applications created for that account.  Select a specific Application to see what Datastore add-on is attached

![Heroku Dashboard - Banking on Clojure overview](https://raw.githubusercontent.com/practicalli/graphic-design/live/heroku/screenshots/heroku-dashboard-banking-on-clojure-staging-overview.png)


## DATABASE_URL Configuration Variable

Provisioning an Heroku Postgres add-on automatically adds a `DATABASE_URL` environment variable to the Heroku app.  Use this value to connect consistently throughout the life of your database from the Heroku application

To see the value of the `DATABSAE_URL` use the Heroku Toolbelt command `heroku config`, specifying the app name if you created multiple Heroku apps for the current project

```bash
heroku config

heroku config --app my-app-name
```

![Heroku Toolbelt - view the DATABASE_URL]()


> #### Hint::Database Clients and other Services
> The value of the DATABASE_URL can be used to connect remote database clients (DBeaver, PGAdmin) as well as other services that require a data store.
