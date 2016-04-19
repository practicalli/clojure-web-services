# Environment Variables

  When you add an Heroku Postgres database to your app, it creates a `DATABASE_URL` configuration variable (environment variable manged by Heroku).
  
> **Note** Check your Heroku app has a `DATABASE_URL` configuration variable for your database

List all the configuration variables for your app using the command:

```
heroku config 
```

The `DATABASE_URL` contains your **username** and **password** for the database, as well as the **hostname** and **database name** in the form of:

```
postgres://username:password@hostname/database-name
```

The Heroku Postres database is available via an secure connection from anywhere on the Internet, so you can use these details with your favourite postgres client.  The postgres client must connect over SSL, or the connection will be rejected by Heroku postgres.
