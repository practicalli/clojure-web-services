# Heroku Dataclips

Its very easy to create quick reports on your Heroku Postgres database using Dataclips and share the results with your company.

Heroku Dataclips allow you to write SQL queries that run on Heroku Postgres.  You can then share these queries along with the results via a web address.

You can give people the ability to create their own query based on yours and share their version of the query and results.  Its kind of Github or Gists for databases.

## Finding tables in Heroku Postgres


```sql
SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema'
```

