# Performance Analytics

Performance Analytics is the visibility suite for Heroku Postgres. It enables you to monitor the performance of your database and to diagnose potential problems. It consists of several components:
Expensive Queries

The leading cause of poor database performance is unoptimized queries. Expensive Queries, available through postgres.heroku.com helps to identify and understand the queries that take the most time in your database. Full documentation is available here.

## Logging

If your application/framework emits logs on database access, you will be able to retrieve them through Heroku’s log-stream:

```
 heroku logs -t
```

To see logs from the database service itself you can also use heroku logs but with the -p postgres flag indicating that you only wish to see the logs from PostgreSQL.

```
 heroku logs -p postgres -t
```

In order to have minimal impact on database performance, logs are delivered on a best-effort basis.

Read more about Heroku Postgres log statements here.


## pg:diagnose

pg:diagnose performs a number of useful health and diagnostic checks that help analyst and optimize the performance of a database. The report that can be shared with others on your team or with Heroku Support.

Before taking any action based on a report, be sure to carefully consider the impact to your database and application.

```
 heroku pg:diagnose --app sushi
Report 1234abc… for sushi::HEROKU_POSTGRESQL_MAROON_URL
available for one month after creation on 2014-07-03 21:29:40.868968+00

GREEN: Connection Count
GREEN: Long Queries
GREEN: Idle in Transaction
GREEN: Indexes
GREEN: Bloat
GREEN: Hit Rate
GREEN: Blocking Queries
GREEN: Load
```

## Check: Connection Count

Each Postgres connection requires memory. And database plans have a limit on the number of connections they can accept. If you are using too many connections you may want to consider using a connection pooler such as PgBouncer or migrating to a larger plan with more RAM.
Checks: Long Running Queries, Idle in Transaction

Long-running queries and transactions can cause problems with bloat that prevents auto vacuuming and causes followers to lag behind. They also create locks on your data which can prevent other transactions from running. You may want to consider killing the long running query with pg:kill.


## Check: Indexes

The Indexes check includes three classes of indexes.

Never Used Indexes have not been used (since the last manual database statistics refresh). These indexes are typically safe to drop, unless they are in use on a follower.

Low Scans, High Writes indexes are used, but infrequently relative to their write volume. Indexes are updated on every write, so are especially costly on a high write table. Consider the cost of slower writes against the performance improvements that these indexes provide.

Seldom used Large Indexes are not used often and take up a significant space both on disk and in cache (RAM). These indexes may still be important to your application for example if they are used by periodic jobs or infrequent traffic patterns.

Index usage is only tracked on the database receiving the query. If you use followers for reads, this check will not account for usage made against the follower and is likely inaccurate.


## Check: Bloat

Because Postgres uses MVCC old versions of updated or deleted rows are simply made invisible rather than modified in place. Under normal operation an auto vacuum process goes through and asynchronously cleans these up. However sometimes it cannot work fast enough or otherwise cannot prevent some tables from becoming bloated. High bloat can slow down queries, waste space, and even increase load as the database spends more time looking through dead rows.

You can manually vacuum a table with the VACUUM (VERBOSE, ANALYZE); command in psql. If this occurs frequently you may want to make autovacuum more aggressive.


## Check: Hit Rate

This checks the overall index hit rate, the overall cache hit rate, and the individual index hit rate per table. It is very important to keep hit rates in the 99+% range. Databases with lower hit rates perform significantly worse as they have to hit disk instead of reading from memory. Consider migrating to a larger plan for low cache hit rates, and adding appropriate indexes for low index hit rates.
Check: Blocking Queries

Some queries can take locks that block other queries from running. Normally these locks are acquired and released very quickly and do not cause any issues. In pathological situations however some queries can take locks that cause significant problems if held too long. You may want to consider killing the query with pg:kill.


## Check: Load

There are many, many reasons that load can be high on a database: bloat, CPU intensive queries, index building, and simply too much activity on the database. Review your access patterns, and consider migrating to a larger plan which would have a more powerful processor.
