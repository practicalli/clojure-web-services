# Using next.jdbc with a Connection pool
As the scale of database use increases it becomes more efficient to continually re-use existing connections to the database, rather than create a new connection to execute each SQL statement.

A connection pool is a set of open connections that are used over and over again, enhancing the performance of the database and allowing the database to scale more efficiently.

Databases may provide their own connection pool (postgres has ..., h2 has ...).  Hikari and c3p0  are commonly used database connection pool libraries

![Clojure WebApps Connection Pool concept](https://raw.githubusercontent.com/practicalli/graphic-design/live/practicalli-clojure-webapps-database-postgres-connection-pool.png)

## Configure next.jdbc with a connection pool

* Add connection pool library (question: if using a db connection pool, is this just the driver?)
* Require `next.jdbc` and `next.jdbc.connection` in the Clojure namespace where the connection pool will be used


{% tabs hikari="hikari", c3p0="C3P0", h2="H2 database", postgresql="PostgreSQL database" %}

{% content "hikari" %}

```clojure
(ns my.main
  (:require
    [next.jdbc :as jdbc]
    [next.jdbc.connection :as connection])

  (:import
    (com.zaxxer.hikari HikariDataSource)))
```

Create a database specification

> HikariCP requires `:username` instead of `:user` in the db-spec

```clojure
(def ^:private db-spec {:dbtype "..." :dbname "..." :username "..." :password "..."})
```

> When using a JDBC URL with a connection pool, use `:jdbcUrl` in the database spec instead of `:dbtype`, `:dbname`, etc)



{% content "c3p0" %}


```clojure
(ns my.main
  (:require
    [next.jdbc :as jdbc]
    [next.jdbc.connection :as connection])

  (:import
    (com.mchange.v2.c3p0 ComboPooledDataSource PooledDataSource)))
```

{% content "h2" %}
{% content "postgresql" %}

{% endtabs %}


## Execute with a connection pools

`next.jdbc.connection/->pool` takes a connection pool (Java Class) and a database specification.



```clojure
(with-open [^HikariDataSource ds (connection/->pool HikariDataSource db-spec)]
    (jdbc/execute! ds ...)
    (jdbc/execute! ds ...)
    (do-other-stuff ds args)
    (into [] (map :column) (jdbc/plan ds ...)))
```


# Configure next.jdbc with lifecycle management libraries
A connection pool has a start/stop lifecycle, so fits easily into lifecycle managment libraries such as mount, component and integrant.

Start the database server connection pool

> Assumes database is a separate service already running.  Add a check for the status of the database before starting the components?


{% tabs mount="Mount", component="Component", integrant="Integrant" %}

{% content "mount" %}

{% content "component" %}
`next.jdbc.connection/component` supports Component directly by creating a Component-compatible entity.

[Example code from next.jdbc.connection/component](https://github.com/seancorfield/next-jdbc/blob/develop/src/next/jdbc/connection.clj#L318-L343)

```clojure
(component/start (connection/component HikariDataSource db-spec))
```

```clojure
(ns practicalli.application
  (:require
    [com.stuartsierra.component :as component]
    [next.jdbc :as jdbc]
    [next.jdbc.connection :as connection])

  (:import
    (com.zaxxer.hikari HikariDataSource)))

(def ^:private db-spec {:dbtype "..." :dbname "..." :username "..." :password "..."})

(defn -main [& args]
  ;; connection/component takes the same arguments as connection/->pool:
  (let [ds (component/start (connection/component HikariDataSource db-spec))]
    (try
      ;; "invoke" the data source component to get the javax.sql.DataSource:
      (jdbc/execute! (ds) ...)
      (jdbc/execute! (ds) ...)
      ;; can pass the data source component around other code:
      (do-other-stuff ds args)
      (into [] (map :column) (jdbc/plan (ds) ...))
      (finally
        ;; stopping the component will close the connection pool:
        (component/stop ds)))))
```

{% content "integrant" %}

{% endtabs %}




<!-- using next.jdbc ->pool with integrant? -->

<!-- cannot get `:serverTimezone` to pass through the pooled datasource. -->

<!-- something like this would work: -->

<!-- ```clojure -->
<!-- (defmethod ig/init-key :db/datasource [_ config] -->
<!--   (next.jdbc.connection/->pool HikariDataSource (:db-pool-spec config))) -->
<!-- ``` -->

<!-- `:db-pool-spec` would be a hash map in the config with all of the parameters to pass into HikariDataSource. -->

<!-- roughly what I have (except for spraying things over namespaces - for lack of guidance) -->
<!-- ```clojure -->
<!-- (defn get-pool [] -->
<!--   (connection/->pool ComboPooledDataSource db-spec)) -->
<!-- ``` -->

<!-- but I am getting this -->
<!-- ``` -->
<!-- Caused by: com.mysql.cj.exceptions.InvalidConnectionAttributeException: The server time zone value 'AEST' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the 'serverTimezone' configuration property) to use a more specifc time zone value if you want to utilize time zone support. -->
<!-- ``` -->
<!-- given -->
<!-- ``` -->
<!-- (def db-spec -->
<!--   {:port 3306 :host "localhost" :dbtype "mysql" -->
<!--    :dbname "test" :user "tester" -->
<!--    :password "password" :useSSL false :serverTimezone "UTC"}) -->
<!-- ``` -->
<!-- I can kick the tyres on Hikari -->
<!-- this seems to be a new burden on the next.jdbc dbtype to notice :serverTimezone and append it to the jdbcUrl - just hypothesising -->

<!-- If you're making a non-pooled datasource, everything in the hash map goes into the URL already. So this is just about keeping either HikariCP or c3p0 happy. -->
<!-- Looking at the docs for those, neither seem to support it as a connection parameter which is a pain... -->
<!-- I guess I'm going to need to expose the machinery in next.jdbc.connection that actually builds JDBC URLs so you can separate out the connection string from the pooled datasource parameters :disappointed: -->
<!-- https://github.com/seancorfield/next-jdbc/issues/138 -->
<!-- c3p0/HikariCP do not support serverTimezone so there is no way to pass this through -->

<!-- Need to expose next.jdbc's JDBC URL string builder I think, in such a way that you can construct the string in one call and pass :jdbcUrl and any pool parameters into the connection pooling library. Affects ->pool and component. -->
<!-- <https://github.com/seancorfield/next-jdbc|seancorfield/next-jdbc>seancorfield/next-jdbc | 6 Aug | Added by GitHub -->
<!-- 01:54 -->
<!-- That's not going to be as easy as I'd hoped -- the URL-builder only builds the minimal JDBC URL and then assumes everything else can be passed as properties when the connection is requested -- which is fine for the simple call to the DriverManager but not so good for the pooled datasource... -->
<!-- seancorfield  02:23 -->
<!-- @gmercer OK, seancorfield/next.jdbc {:mvn/version "1.1.582"} is available on Clojars for you -- it adds next.jdbc.connection/jdbc-url: see its docstring for usage details. -->
<!-- 02:25 -->
<!-- Not well-tested but should get you going again. I'd probably recommend omitting :user/:password from the db-spec and instead provide them in the hash map along with :jdbcUrl that you pass into the pooling library (and be careful that one expects :user like JDBC and the other lib expects :username instead -- which is mentioned in the docs). -->
<!-- gmercer  02:36 -->
<!-- @seancorfield thanks - I tried mimicking your spec->url+etc .. nearly there but will try the latest version ... thanks heaps considering timezones :wink: -->
<!-- seancorfield  02:39 -->
<!-- Yeah, the spec->url+etc function is only about half of what you need... (edited) -->
<!-- gmercer  03:00 -->
<!-- @seancorfield thanks - works like a bought one -->
<!-- seancorfield  03:12 -->
<!-- I definitely need to create some tests around it and expand the documentation... but I just wanted to get this out for you a.s.a.p. -->
