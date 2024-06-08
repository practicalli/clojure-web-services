# Managing database connections

A Clojure application / REPL can connect to a database source and request a new connection.  This connection can be used to send SQL statements to the database and receive the results.

In a single threaded application, then only one connection to each database would be created.  In a multi-threaded application then multiple connections to the database may be created.  If multiple instances of an application are deployed, then multiple database connections will be created.

As the number of simultaneous connections to the database grows, the more need for a [connection pool](http://en.wikipedia.org/wiki/Connection_pool) service to maximize the performance of the database.


## PostgreSQL

When a client connects to PostgreSQL database the parent process spawns a worker process which listens to the newly created connection. Spawning a work process each time can support a small number of database connections. As the number of simultaneous connections increases, CPU and memory resources also increase.

Without a connection pool a new database connection is created for each client.

![Clojure WebApps - PostgreSQL database connection pool](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-webapps-database-postgres-no-connection-pool.png)

> #### Hint::Limits via PostgreSQL configuration
> The [`max_connections` configuration](https://www.postgresql.org/docs/12/runtime-config-connection.html) for PostgreSQL limits the number of client connections allowed, so additional connections are refused or dropped.


## Connection pool with PostgreSQL

A [connection pool](http://en.wikipedia.org/wiki/Connection_pool) shares a fixed set of recyclable connections which can manage a large numbers of simultaneous connections due to the reduced CPU and memory usage.

The fixed set of connections is called the pool size and it is recommended to test the size of the pool used during integration tests.

A connection pool can efficiently deal with idle or stagnant client connections, as well as queue up client requests during traffic spikes instead of rejecting them.

![Clojure WebApps - PostgreSQL database connection pool](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-webapps-database-postgres-connection-pool.png)


## Connection pool implementations

A connection pool can be implemented either on the application side or as middleware between the database and your application.

* [pgBouncer](http://www.pgbouncer.org/) - a lightweight, open-source middleware connection pool for PostgreSQL.
* [HikariCP](https://github.com/brettwooldridge/HikariCP) - Fast, simple, reliable. HikariCP is a "zero-overhead" production ready JDBC connection pool. At roughly 130Kb, the library is very light.
* [c3p0](https://www.mchange.com/projects/c3p0/) - an easy-to-use library for making traditional JDBC drivers "enterprise-ready" by augmenting them with functionality defined by the jdbc3 spec and the optional extensions to jdbc
* [Heroku pgBouncer build-pack](https://github.com/gregburek/heroku-buildpack-pgbouncer), [Heroku Postgres connection limit guidance](https://blog.heroku.com/connection_limit_guidance) and [Heroku Postgres plans] with connection limits.
* [Tuning your PostgreSQL Server - wiki.postgresql.org](https://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server)
* [PostgreSQL  12.4 Documentation](https://www.postgresql.org/docs/12/index.html)
