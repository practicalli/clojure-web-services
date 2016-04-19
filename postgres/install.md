# Postgres install

  Its more accurate to say we are provisioning the Postgres database when using Heroku.  Using the Heroku app you created previously, we will add a posgres database.
  
  
> **Note** In to root of your Clojure project, run the following Heroku toolbelt command to add a Postgres database to your existing Heroku app

```
heroku addons:create heroku-postgresql
```

