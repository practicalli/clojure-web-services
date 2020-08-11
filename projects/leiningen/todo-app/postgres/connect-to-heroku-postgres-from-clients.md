# Connecting to Heroku Postgres from Postgres Clients

* Command Line
* GUI tools
* Operations tools


Heroku Postgres databases are accessible from anywhere via a secure http connection, so you can connect your favourite Postgres client.

> ####Hint:: All Heroku Postgres databases have a corresponding Heroku application. You can find the application name on the database page from postgres.heroku.com/databases. You do not have to use the Heroku app for application code, but your database is attached to it and holds an environment variable containing the database URL. This variable is managed by Heroku, and is the primary way we tell you about your database’s network location and credentials.

## DATABASE_URL Configuration Variable

When you provision an Heroku Postgres, the `DATABAE_URL` configuration variable is set for your Heroku app.  You can then use this value to connect consisently throughout the life of your database.

To see the value of the `DATABSAE_URL` use the Heroku Toolbelt command `heroku config`, specifying the app name if you created multiple Heroku apps for the current project

```
heroku config

heroku config --app my-app-name
```

![Heroku Toolbelt - view the DATABASE_URL]()
