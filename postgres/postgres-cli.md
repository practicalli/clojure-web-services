# Postgres CLI

Heroku toolbelt has many commands for viewing information and querying the Heroku Postgres database.  Here is a breakdown of the most commonly used commands.

> ####Hint::Postgres Command Line Client required
> Heroku Toolbelt `pg` commands require a working postgres command line client to be installed and available on your operating system path.
>
> [Ubuntu documentation: PostgreSQL](https://help.ubuntu.com/community/PostgreSQL) has details on installing postgresql clients.

## Postgres Information

To see all PostgreSQL databases provisioned by your application and the identifying characteristics of each (db size, status, number of tables, PG version, creation date etc…) use the `heroku pg:info` command.

```
$ heroku pg:info
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
```

To continuously monitor the status of your database, pass pg:info through the unix watch command:
```
watch heroku pg:info
```


## Running Queries on Postgres

psql is the native PostgreSQL interactive terminal and is used to execute queries and issue commands to the connected database.  To establish a psql session with your remote database use heroku pg:psql. You must have PostgreSQL installed on your system to use `heroku pg:psql`.

```
$ heroku pg:psql
---> Connecting to HEROKU_POSTGRESQL_BROWN_URL (DATABASE_URL)
psql (9.2.6, server 9.3.3)
WARNING: psql version 9.2, server version 9.3.
         Some psql features might not work.
SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
Type "help" for help.

heroku-app-name::BROWN=> \dt
               List of relations
 Schema |     Name     | Type  |     Owner
--------|--------------|-------|----------------
 public | pl0_programs | table | moiwgreelvvujc
(1 row)

heroku-app-name::BROWN=>
heroku-app-name::BROWN=> SELECT * FROM pl0_programs;
  name  |           source
--------|-----------------------------
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
```

If you have more than one database, specify the database to connect to as the first argument to the command (the database located at `DATABASE_URL` is used by default).

```
$ heroku pg:psql HEROKU_POSTGRESQL_GRAY
Connecting to HEROKU_POSTGRESQL_GRAY... done
```

## Reset your database

To drop and recreate your database use `heroku pg:reset`

```
$ heroku pg:reset DATABASE

 !    WARNING: Destructive Action
 !    This command will affect the app: heroku-app-name
 !    To proceed, type "pegjspl0" or re-run this command with --confirm heroku-app-name

> heroku-app-name
Resetting HEROKU_POSTGRESQL_BROWN_URL (DATABASE_URL)... done
```

Then restart the server

```
$ heroku ps:restart
Restarting dynos... done
```

There are many more Heroku toolbelt commands you can use for postgres. [TODO: Link to postgres command]


## Resources
* [Accessing a Database](https://www.postgresql.org/docs/12/tutorial-accessdb.html) - postgresql.org
* [Ubuntu documentation: PostgreSQL](https://help.ubuntu.com/community/PostgreSQL) - client and server install
