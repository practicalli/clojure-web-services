# Environment Variables

  Add an Heroku Postgres database to the Heroku app creates a `DATABASE_URL` configuration variable, an environment variable manged by Heroku.  This configuration variable can be used to avoid including database connection details in the code repository.

> ####Note:: Check your Heroku app has a `DATABASE_URL` configuration variable
> List all the configuration variables for your app using the command:
>
```
heroku config
```
>
> The `DATABASE_URL` contains your **username** and **password** for the database, as well as the **hostname** and **database name** in the form of:
>
```
postgres://username:password@hostname/database-name
```


## Using PostgreSQL client applications
The Heroku Postres database is available via an secure connection from anywhere on the Internet, so you can use these details with your favourite postgres client.  The postgres client must connect over SSL, or the connection will be rejected by Heroku postgres.
