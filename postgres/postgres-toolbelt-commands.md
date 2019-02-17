## Heroku Toolbelt for Postgres

Heroku Postgres is integrated directly into the Heroku toolbelt and offers several commands that automate many common tasks associated with managing a database-backed application.

> ####Hint:: Some of these commands require a postgres cleint to be installed on your computer to work.

## pg:info

To see all PostgreSQL databases provisioned by your application and the identifying characteristics of each (db size, status, number of tables, PG version, creation date etc…) use the heroku pg:info command.

```
 heroku pg:info
=== HEROKU_POSTGRESQL_RED
Plan         Standard 0
Status       available
Data Size    82.8 GB
Tables       13
PG Version   9.1.3
Created      2012-02-15 09:58 PDT
=== HEROKU_POSTGRESQL_GRAY
Plan         Standard 2
Status       available
Data Size    82.8 GB
…
```

To continuously monitor the status of your database, pass pg:info through the unix watch command:

```
 watch heroku pg:info
``


## pg:psql

psql is the native PostgreSQL interactive terminal and is used to execute queries and issue commands to the connected database.

To establish a psql session with your remote database use heroku pg:psql.

You must have PostgreSQL installed on your system to use heroku pg:psql.

 heroku pg:psql
Connecting to HEROKU_POSTGRESQL_RED... done
psql (9.1.3, server 9.1.3)
SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

rd2lk8ev3jt5j50=> SELECT * FROM users;

If you have more than one database, specify the database to connect to (just the color works as a shorthand) as the first argument to the command (the database located at DATABASE_URL is used by default).

 heroku pg:psql gray
Connecting to HEROKU_POSTGRESQL_GRAY... done
...

pg:push and pg:pull
pg:pull

pg:pull can be used to pull remote data from a Heroku Postgres database to a database on your local machine. The command looks like this:

 heroku pg:pull HEROKU_POSTGRESQL_MAGENTA mylocaldb --app sushi

This command will create a new local database named “mylocaldb” and then pull data from database at DATABASE_URL from the app “sushi”. In order to prevent accidental data overwrites and loss, the local database must not exist. You will be prompted to drop an already existing local database before proceeding.

If providing a Postgres user or password for your local DB is necessary, use the appropriate environment variables like so:

 PGUSER=postgres PGPASSWORD=password heroku pg:pull HEROKU_POSTGRESQL_MAGENTA mylocaldb --app sushi

Note: like all pg:* commands you can use the shorthand identifiers here, so to pull data from HEROKU_POSTGRESQL_RED on the app “sushi” you could do heroku pg:pull sushi::RED mylocaldb.
pg:push

Like pull but in reverse, pg:push will push data from a local database into a remote Heroku Postgres database. The command looks like this:

 heroku pg:push mylocaldb HEROKU_POSTGRESQL_MAGENTA --app sushi

This command will take the local database “mylocaldb” and push it to the database at DATABASE_URL on the app “sushi”. In order to prevent accidental data overwrites and loss, the remote database must be empty. You will be prompted to pg:reset an already a remote database that is not empty.

Usage of the PGUSER and PGPASSWORD for your local database is also supported for pg:push, just like for the pg:pull commands.
Troubleshooting

These commands rely on the pg_dump and pg_restore binaries that are included in a Postgres installation. It is somewhat common, however, for the wrong binaries to be loaded in $PATH. Errors such as

!    createdb: could not connect to database postgres: could not connect to server: No such file or directory
!      Is the server running locally and accepting
!      connections on Unix domain socket "/var/pgsql_socket/.s.PGSQL.5432"?
!
!    Unable to create new local database. Ensure your local Postgres is working and try again.

and

pg_dump: server version: 9.3.1; pg_dump version: 9.1.5
pg_dump: aborting because of server version mismatch
pg_dump: *** aborted because of error
pg_restore: [archiver] input file is too short (read 0, expected 5)

are both often a result of this incorrect $PATH problem. This problem is especially common with Postgres.app users, as the post-install step of adding /Applications/Postgres.app/Contents/MacOS/bin to $PATH is easy to forget.
pg:ps, pg:kill, pg:killall

These commands give you view and control over currently running queries.

The pg:ps command queries the pg_stat_statements table in postgres to give a concise view into currently running queries.

 heroku pg:ps
 procpid |         source            |   running_for   | waiting |         query
---------|---------------------------|-----------------|---------|-----------------------
   31776 | psql                      | 00:19:08.017088 | f       | <IDLE> in transaction
   31912 | psql                      | 00:18:56.12178  | t       | select * from hello;
   32670 | Heroku Postgres Data Clip | 00:00:25.625609 | f       | BEGIN READ ONLY; select 'hi'
(3 rows)

The procpid column can then be used to cancel or terminate those queries with pg:kill. Without any arguments pg_cancel_backend is called on the query which will attempt to cancel the query. In some situations that can fail, in which case the --force option can be used to issue pg_terminate_backend which drops the entire connection for that query.

 heroku pg:kill 31912
 pg_cancel_backend
-------------------
 t
(1 row)

 heroku pg:kill --force 32670
 pg_terminate_backend
----------------------
 t
(1 row)

pg:killall is similar to pg:kill except it will cancel or terminate every query on your database.
pg:promote

In setups where more than one database is provisioned (common use-cases include a master/slave high-availability setup or as part of the database upgrade process) it is often necessary to promote an auxiliary database to the primary role. This is accomplished with the heroku pg:promote command.

 heroku pg:promote HEROKU_POSTGRESQL_GRAY_URL
Promoting HEROKU_POSTGRESQL_GRAY_URL to DATABASE_URL... done

pg:promote works by setting the value of the DATABASE_URL config var (which your application uses to connect to the primary database) to the newly promoted database’s URL and restarting your app. The old primary database location is still accessible via its HEROKU_POSTGRESQL_COLOR_URL setting.

After a promotion, the demoted database is still provisioned and incurring charges. If it’s no longer need you can remove it with heroku addons:destroy HEROKU_POSTGRESQL_COLOR.
pg:credentials

Heroku Postgres provides convenient access to the credentials and location of your database should you want to use a GUI to access your instance.

The database name argument must be provided with pg:credentials command. Use DATABASE for your primary database.

 heroku pg:credentials DATABASE
Connection info string:
   "dbname=dee932clc3mg8h host=ec2-123-73-145-214.compute-1.amazonaws.com port=6212 user=user3121 password=98kd8a9 sslmode=require"

It is a good security practice to rotate the credentials for important services on a regular basis. On Heroku Postgres this can be done with heroku pg:credentials --reset.

 heroku pg:credentials HEROKU_POSTGRESQL_GRAY_URL --reset

When you issue this command, new credentials are created for your database and the related config vars on your Heroku application are updated. However, on Standard, Premium, and Enterprise tier databases the old credentials are not removed immediately. All of the open connections remain open until the currently running tasks complete, then those credentials are updated. This is to make sure that any background jobs or other workers running on your production environment aren’t abruptly terminated, potentially leaving the system in an inconsistent state.
pg:reset

The PostgreSQL user your database is assigned doesn’t have permission to create or drop databases. To drop and recreate your database use pg:reset.

 heroku pg:reset DATABASE
