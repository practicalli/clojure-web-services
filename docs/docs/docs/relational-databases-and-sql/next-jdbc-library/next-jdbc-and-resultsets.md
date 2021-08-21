# next.jdbc and resultsets

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

That is expected `:fetch-size` is not a limit, it's just a hint for each "chunk" of the overall result set during database access.

But we are facing memory issues and we think this not being lazy is the cause, number of rows are in the order of a few 100,000 rows to a million

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
