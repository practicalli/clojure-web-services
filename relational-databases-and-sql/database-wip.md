# Database research


## Connection management
does jdbc-next re-connect to the database with each query?

using a db-spec (hash map) or connection URL string, next.jdbc will make a datasource from that and then call .getConnection on it; if you use a datasource, both libraries will call .getConnection on it. You can either use get-connection and with-open (as shown in the docs) to reuse a connection across multiple operations, or you can use a connection pooled datasource (the recommended approach).

next.jdbc has built-in support for both HikariCP and c3p0 (and any others that follow the same API pattern as those two -- but those two are the supported and tested ones).
On shared hosting, it's entirely possible that standing up a new DB connection is very expensive (it's expensive, in relative terms, even locally but not so much that you really notice).
For any type of production app, I would always use connection pooling https://cljdoc.org/d/seancorfield/next.jdbc/1.1.582/doc/getting-started#connection-pooling (edited)



## User and system credentials

call get-connection with username and password in next-jdbc. I would like to propose a patch but am unsure if you would prefer to have username and pw as part of opts or as new arities of get-connection.

@strsnd Is there a reason for you to not provide :user and :password as part of the hash map passed to get-datasource?
strsnd  19:27
@seancorfield Sure, that's possible. But I am using different users with the same datasource and thought this approach would be cleaner and could help others as well.

seancorfield  19:29
The DataSource object supports (.getConnection ds username password) so you could get your connections that way.
(and that's true of the reified DataSource that get-datasource produces from a hash map or URL)

seancorfield  19:34
If you use a connection pooled datasource, aren't you restricted to a single user/password (since you have to provide that to c3p0 or HikariCP)? Or do those support connection-level user/password settings?
19:38
Given that I can't change the Connectable protocol without (potentially) breaking existing code, I'd want to pass :user / :password via the opts there (even if next.jdbc/get-connection was updated to have extra arities, it would resolve to (p/get-connection spec opts) under the hood), so then I think the only change would be this line in the private make-connection function would need to check for those keys in the opts:

  (let [^Connection connection (.getConnection datasource)]

would become something like

  (let [^Connection connection (if (and (:user opts) (:password opts)) (.getConnection datasource (:user opts) (:password opts)) (.getConnection datasource))]

^ @strsnd Thoughts?
 hikari will throw an Unsupported SQL Exception, c3p0 has different pools for username+password
The simple PostgreSQL Pool will just open a non-pooled Connection in this case.
(for the reified DataSource, that arity .getConnection only folds the username and password back into the etc hash map under the hood when calling DriverManager/getConnection anyway)

@noisesmith they are distinct pools in c3p0, they are hashed by user+pw, the other pools that don't support it just throw an exception (edited)

I try to use a ro user most of the time and just for some actions need to elevate

We have separate datasources for r/o vs r/w so it's usually very clear in our code which one is being used where.



convert a parametrized sql statement like ["SELECT * FROM USER WHERE ID = ?" 9] to a prepared statement in clojure.jdbc? The prepare statement only accepts a string and not a vector
It is possible in next.jdbc


## Integrant and next.jdbc
Is there an example on the interwebs using next.jdbc ->pool with integrant?
cannot get :serverTimezone to pass through the pooled datasource.

```clojure
(defmethod ig/init-key :db/datasource [_ config]
  (next.jdbc.connection/->pool HikariDataSource (:db-pool-spec config)))
```

and `:db-pool-spec` would be a hash map in the config with all of the parameters to pass into HikariDataSource.

Hi @seancorfield, that is roughly what I have (except for spraying things over namespaces - for lack of guidance)
(defn get-pool []
  (connection/->pool ComboPooledDataSource db-spec))

but I am getting this
Caused by: com.mysql.cj.exceptions.InvalidConnectionAttributeException: The server time zone value 'AEST' is unrecognized or represents more than one time zone. You must configure either the server or JDBC driver (via the 'serverTimezone' configuration property) to use a more specifc time zone value if you want to utilize time zone support.
given
(def db-spec
  {:port 3306 :host "localhost" :dbtype "mysql"
   :dbname "test" :user "tester"
   :password "password" :useSSL false :serverTimezone "UTC"})

this seems to be a new burden on the next.jdbc dbtype to notice :serverTimezone and append it to the jdbcUrl - just hypothesising

seancorfield  01:45
If you're making a non-pooled datasource, everything in the hash map goes into the URL already. So this is just about keeping either HikariCP or c3p0 happy.
Looking at the docs for those, neither seem to support it as a connection parameter which is a pain...
I guess I'm going to need to expose the machinery in next.jdbc.connection that actually builds JDBC URLs so you can separate out the connection string from the pooled datasource parameters :disappointed:
https://github.com/seancorfield/next-jdbc/issues/138
#138 c3p0/HikariCP do not support serverTimezone so there is no way to pass this through
Need to expose next.jdbc's JDBC URL string builder I think, in such a way that you can construct the string in one call and pass :jdbcUrl and any pool parameters into the connection pooling library. Affects ->pool and component.
That's not going to be as easy as I'd hoped -- the URL-builder only builds the minimal JDBC URL and then assumes everything else can be passed as properties when the connection is requested -- which is fine for the simple call to the DriverManager but not so good for the pooled datasource...
seancorfield/next.jdbc {:mvn/version "1.1.582"} is available on Clojars for you -- it adds next.jdbc.connection/jdbc-url: see its docstring for usage details.
Not well-tested but should get you going again. I'd probably recommend omitting :user/:password from the db-spec and instead provide them in the hash map along with :jdbcUrl that you pass into the pooling library (and be careful that one expects :user like JDBC and the other lib expects :username instead -- which is mentioned in the docs).
the spec->url+etc function is only about half of what you need... (edited)




We are using the db-query-with-resultset  to apply a result-set-fn on the result-set lazily (in the db sense) but the fetch-size doesnt seem to be respected. If I do a (count result-set) it returns the size of the all the rows expected from the query instead of the fetch size, this is how our function looks like. clojure.java.jdbc version is "0.3.5"
```clojure
(defn do-lazy-read [db-spec sql-params size result-set-fn]
  (jdbc/db-query-with-resultset
    db-spec
    (into [] (cons {:fetch-size size} sql-params))
    (fn [result-set]
      (prn (count result-set))
      (-> result-set
          (jdbc/result-set-seq :identifiers qstr/underscores->hyphens)
          result-set-fn))))
```

that is expected : fetch size is not a limit, it's just a hint for each "chunk" of the overall result set during database access.
But we are facing memory issues and we think this not being lazy is the cause, number of rows are in the order of a few 100,000 rows
to a million

You need reducible-query
Haven’t used it before, but it seems it will close the connection after reducing the result-set, how would I go about maintaining the cursor? (edited)
I am going through the documentation, will explore reducible query. But the question is if lets say the fetch size 1000 is just a hint, why is the hint not considered? Why would it always return all the rows, that too rows close to a million?
Reading this answer of yours https://stackoverflow.com/questions/39765943/clojure-java-jdbc-lazy-query/39775018#39775018 and the linked docs and the other SO question on why jdbc ignores setFetchSize (edited)
1. fetch size tells the JDBC driver to try to only fetch that many rows at a time but it is not a limit on how many rows come back in the result set
17:43
2. the result set is built lazily -- so result-set is a lazy sequence and if you call count you will realize the entire sequence, which will be you 1M rows
17:44
3. even trying to process result set lazily and using fetch, you are at the usual mercy of Clojure's treatment of very large lazy sequences -- and you must completely process the result set before c.j.j. closes the connection (otherwise you'll get errors when you try to realize the next piece of the lazy result set -- because it relies on the connection staying open).
17:45
4. since all of that is very tricky (as you're discovering), reducible-query was added so you can process the result set in a single pass reduction without needing to worry about laziness
17:46
FWIW, next.jdbc is built on that concept as a primary API: next.jdbc/plan is explicitly a reducible that is also "foldable" (in the clojure.core.reducers/fold sense so you can achieve some level of concurrency as well).
17:47
The reducible-query function in c.j.j. is the predecessor to next.jdbc/plan -- but the latter is better designed for performance (as is the whole of next.jdbc).
17:49
As another part of #3 above: holding onto the head is definitely a possibility -- as with processing any very large lazy sequence, but you're dealing with a Clojure problem there, not a JDBC problem.
17:49



## Logging

using postgresql, set the log level directly on the driver
https://github.com/pgjdbc/pgjdbc
loggerLevel and loggerFile

Or, you could simply decorate the function that invokes the next.jdbc function ,i.e., execute-one, with a simple "log/tracef" call

The primary reason that there isn't a way to do that is that everyone's logging needs are different so there's really no "one size fits all" thing the library could do for you.
I had started experimenting with some sort of interceptor approach for next.jdbc that would let you hook into execute! both before and after an operation but it was very hard to provide a clean API that didn't also add overhead for everyone, even if they're not using it.
I think, now I have with-options available, I might be able to use a similar approach to do logging -- but it would have the same caveats that with-options has: you need to manually propagate it across transactions and certain other calls (because next.jdbc uses native Java objects for improved performance).


## Performance
Should I expect to see a performance improvement with hugsql when switching from the default adapter to jdbc.next adapter? didn't see much difference when I tried it in a production environment.
We didn't notice any directly, but some things are nicer, like extending PG types as compared to clojure.jdbc

HugSQL isn't using plan, the only performance difference you'll see is in "large" result sets that will be constructed quite a bit faster than with c.j.j
(that can be quite a substantial difference)
Also, if you construct a datasource once from a db-spec, and then use that datasource everywhere, that should also be a bit faster (using a connection pooled datasource would be faster, of course, and that is also true of c.j.j).

I deployed next.jdbc and see speedups of up to 20% in some places.


## Select using Honey sql and mysql database
a select in database using Honey sql in clojure.
My database is MYSQL, and this is the sql that i want:select LPAD(CardPayment.authorization_code, 6, 0) as authorization from CardPayment (edited)
Someone know how to use LPAD function in honeysql? I dont find in the documents and examples


user=> (require '[honeysql.core :as h] '[honeysql.helpers :refer [select from]])
nil
user=> (-> (select #sql/call [:lpad :CardPayment.authorization_code 6 0]) (from :CardPayment) (h/format))
["SELECT lpad(CardPayment.authorization_code, ?, ?) FROM CardPayment" 6 0]

With the AS alias:

user=> (-> (select [#sql/call [:lpad :CardPayment.authorization_code 6 0] :authorization]) (from :CardPayment) (h/format))
["SELECT lpad(CardPayment.authorization_code, ?, ?) AS authorization FROM CardPayment" 6 0]
user=>

And here's an alternative if you need parameters to lpad being evaluated (so it uses h/call instead of the tagged literal):

user=> (-> (select [(h/call :lpad :CardPayment.authorization_code 6 0) :authorization]) (from :CardPayment) (h/format))
["SELECT lpad(CardPayment.authorization_code, ?, ?) AS authorization FROM CardPayment" 6 0]
user=>


## Designing schema

Any resources for designing real-world schemas in sql? Things like blocked users, saving line item price to maintain historical records and all the other messy bits that are needed.

for blocked user detection you may want to use a bloom filter & caching , so you dont penalize "good users" with unnecessary lookups
