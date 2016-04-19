 pg:info

To see all PostgreSQL databases provisioned by your application and the identifying characteristics of each (db size, status, number of tables, PG version, creation date etc…) use the heroku pg:info command.

[~/srcPLgrado/pegjscalc(master)]$ heroku pg:info
=== HEROKU_POSTGRESQL_BROWN_URL (DATABASE_URL)
Plan:        Hobby-dev
Status:      available
Connections: 0
PG Version:  9.3.3
Created:     2014-03-20 23:33 UTC
Data Size:   6.5 MB
Tables:      1
Rows:        4/10000 (In compliance)
Fork/Follow: Unsupported
Rollback:    Unsupported

To continuously monitor the status of your database, pass pg:info through the unix watch command:

[~/srcPLgrado/pegjscalc(master)]$ watch heroku pg:info
-bash: watch: no se encontró la orden
[~/srcPLgrado/pegjscalc(master)]$ brew install watch
[~/srcPLgrado/pegjscalc(master)]$ watch heroku pg:info
...

pg:psql
psql is the native PostgreSQL interactive terminal and is used to execute queries and issue commands to the connected database.

To establish a psql session with your remote database use heroku pg:psql. You must have PostgreSQL installed on your system to use heroku pg:psql.

[~/srcPLgrado/pegjscalc(master)]$ heroku pg:psql
---> Connecting to HEROKU_POSTGRESQL_BROWN_URL (DATABASE_URL)
psql (9.2.6, server 9.3.3)
WARNING: psql version 9.2, server version 9.3.
         Some psql features might not work.
SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

pegjspl0::BROWN=> \dt
               List of relations
 Schema |     Name     | Type  |     Owner      
--------+--------------+-------+----------------
 public | pl0_programs | table | moiwgreelvvujc
(1 row)

pegjspl0::BROWN=> 
pegjspl0::BROWN=> SELECT * FROM pl0_programs;
  name  |           source            
--------+-----------------------------
 3m2m1  |                     3-2-1\r+
        |           
 ap1tb  | a+1*b\r                    +
        |           
 test   |                     a+1*b\r+
        |           \r               +
        |           
 lolwut |                     3-2-1\r+
        |           
(4 rows)

If you have more than one database, specify the database to connect to as the first argument to the command (the database located at DATABASE_URL is used by default).

$ heroku pg:psql HEROKU_POSTGRESQL_GRAY
Connecting to HEROKU_POSTGRESQL_GRAY... done
...

pg:reset
To drop and recreate your database use pg:reset:

[~/srcPLgrado/pegjscalc(master)]$ heroku pg:reset DATABASE

 !    WARNING: Destructive Action
 !    This command will affect the app: pegjspl0
 !    To proceed, type "pegjspl0" or re-run this command with --confirm pegjspl0

> pegjspl0
Resetting HEROKU_POSTGRESQL_BROWN_URL (DATABASE_URL)... done

Es necesario a continuación rearrancar el servidor:

[~/srcPLgrado/pegjscalc(master)]$ heroku ps:restart
Restarting dynos... done

pg:pull
pg:pull can be used to pull remote data from a Heroku Postgres database to a database on your local machine. The command looks like this:

[~/srcPLgrado/pegjscalc(master)]$ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
server starting

$ heroku pg:pull HEROKU_POSTGRESQL_MAGENTA mylocaldb --app sushi

This command will create a new local database named mylocaldb and then pull data from database at DATABASE_URL from the app sushi.

In order to prevent accidental data overwrites and loss, the local database must not exist. You will be prompted to drop an already existing local database before proceeding.

pg:push
Like pull but in reverse, pg:push will push data from a local database into a remote Heroku Postgres database. The command looks like this:

$ heroku pg:push mylocaldb HEROKU_POSTGRESQL_MAGENTA --app sushi

This command will take the local database mylocaldb and push it to the database at DATABASE_URL on the app sushi. In order to prevent accidental data overwrites and loss, the remote database must be empty. You will be prompted to pg:reset an already a remote database that is not empty.



# Backups

You can use Heroku Postgres Backups on the enclosing Heroku app in order to get automated backups on your database. Heroku Postgres Backups takes backups of the database pointed at by DATABASE_URL in the Heroku app, so make sure you promote your database:

heroku pg:promote HEROKU_POSTGRESQL_VIOLET --app your-app



## Monitoring database provisioning 

When provisioning larger databases, they may take several minutes to become available.  Using the `heroku pg:wait` command you can see when the database provisioning is complete.

You may also want to use heroku pg:wait when putting your applicaiton into maintenenace mod [TODO: expand on this]

```
heroku help pg:wait


Usage: heroku pg:wait [DATABASE]

 monitor database creation, exit when complete

 defaults to all databases if no DATABASE is specified

 --wait-interval SECONDS      # how frequently to poll (to avoid rate-limiting)
```

## Setting a name for a new database 

Once Heroku Postgres has been added a `HEROKU_POSTGRESQL_COLOR_URL` setting will be available in the app configuration and will contain the URL used to access the newly provisioned Heroku Postgres service. This can be confirmed using the heroku config command.

```
 heroku config -s | grep HEROKU_POSTGRESQL
HEROKU_POSTGRESQL_RED_URL=postgres://user3123:passkja83kd8@ec2-117-21-174-214.compute-1.amazonaws.com:6212/db982398
```
You can choose the alias that the add-on uses on the application using the --as flag. This will affect the name of the variable the add-on adds to the application:

```
 heroku addons:create heroku-postgresql:hobby-dev --as USERS_DB
Adding heroku-postgresql:hobby-dev to sushi... done, v69 (free)
Attached as USERS_DB
Database has been created and is available

 heroku config -s | grep USERS_DB
USERS_DB_URL=postgres://user3123:passkja83kd8@ec2-117-21-174-214.compute-1.amazonaws.com:6212/db982398
```

