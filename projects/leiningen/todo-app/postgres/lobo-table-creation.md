# How to use Lobos with Heroku

http://pupeno.com/2011/08/20/how-to-use-lobos-with-heroku/

Lobos is a Clojure library to create and alter tables which also supports migrations similar to what Rails can do. I like where Lobos is going but it’s a work in progress, so the information here might be out of date soon, beware!

Let’s imagine a project called px (for Project X of course) with the usual Leiningen structure. In the src directory you you need to create a lobos directory and inside there let’s get started with config.clj which contains the credentials and other database information:

	
(ns lobos.config)
 
(def db
  {:classname "org.postgresql.Driver"
   :subprotocol "postgresql"
   :subname "//localhost:5432/px"})

then we create a simple migration in lobos/migrations.clj that creates the users table:
1
2
3
4
5
6
7
8
9
	
(ns lobos.migrations
  (:refer-clojure :exclude [alter defonce drop bigint boolean char double float time])
  (:use (lobos [migration :only [defmigration]] core schema) lobos.config))
 
(defmigration create-users
  (up [] (create (table :users
                   (integer :id :primary-key)
                   (varchar :email 256 :unique))))
  (down [] (drop (table :users))))

You run a REPL, load the migrations and run them (using the joyful Clojure example code convention):
1
2
3
4
	
(require 'lobos.migrations)
;=> nil
(lobos.core/run)
;=> java.lang.Exception: No such global connection currently open: :default-connection, only got [] (NO_SOURCE_FILE:0)

and you get an error because you didn’t open the connection yet, so, let’s do that:
1
2
3
4
	
(require 'lobos.connectivity)
;=> nil
(lobos.connectivity/open-global lobos.config/db)
;=> {:default-connection {:connection #<Jdbc4Connection org.postgresql.jdbc4.Jdbc4Connection@2ab600af>, :db-spec {:classname "org.postgresql.Driver", :subprotocol "postgresql", :subname "//localhost:5432/px"}}}

and now it works:
1
2
3
	
(lobos.core/run)
; create-users
;=> nil

and you can also rollback:
1
2
3
	
(lobos.core/rollback)
; create-users
;=> nil

You might be tempted to open the global connection in your config.clj and that might be fine for some, but I found it problematic that the second time I load the file, I get an error: “java.lang.Exception: A global connection by that name already exists (:default-connection) (NO_SOURCE_FILE:0)”.

My solution was to write a function called open-global-when-necessary that will open a global connection only when there’s none or when the database specification changed, and will close the previous connection in that case, leaving a config.clj that looks like:
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
	
(ns lobos.config
  (:require lobos.connectivity))
 
(defn open-global-when-necessary
  "Open a global connection only when necessary, that is, when no previous
  connection exist or when db-spec is different to the current global
  connection."
  [db-spec]
  ;; If the connection credentials has changed, close the connection.
  (when (and (@lobos.connectivity/global-connections :default-connection)
             (not= (:db-spec (@lobos.connectivity/global-connections :default-connection)) db-spec))
    (lobos.connectivity/close-global))
  ;; Open a new connection or return the existing one.
  (if (nil? (@lobos.connectivity/global-connections :default-connection))
    ((lobos.connectivity/open-global db-spec) :default-connection)
    (@lobos.connectivity/global-connections :default-connection)))
 
(def db
  {:classname "org.postgresql.Driver"
   :subprotocol "postgresql"
   :subname "//localhost:5432/px"})
 
(open-global-when-necessary db)

That works fine locally, so let’s move to Heroku. To get started with Clojure on Heroku I recommend you read:

    Getting Started With Clojure on Heroku/Cedar
    Building a Database-Backed Clojure Web Application

I took the code used to extract the database specification from DATABASE_URL but I modified it so I don’t depend on that environment variable existing on my local computer and I ended up with the following config.clj:
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
	
(ns lobos.config
  (:require [clojure.string :as str] lobos.connectivity)
  (:import (java.net URI)))
 
(defn heroku-db
  "Generate the db map according to Heroku environment when available."
  []
  (when (System/getenv "DATABASE_URL")
    (let [url (URI. (System/getenv "DATABASE_URL"))
          host (.getHost url)
          port (if (pos? (.getPort url)) (.getPort url) 5432)
          path (.getPath url)]
      (merge
       {:subname (str "//" host ":" port path)}
       (when-let [user-info (.getUserInfo url)]
         {:user (first (str/split user-info #":"))
          :password (second (str/split user-info #":"))})))))
 
(defn open-global-when-necessary
  "Open a global connection only when necessary, that is, when no previous
  connection exist or when db-spec is different to the current global
  connection."
  [db-spec]
  ;; If the connection credentials has changed, close the connection.
  (when (and (@lobos.connectivity/global-connections :default-connection)
             (not= (:db-spec (@lobos.connectivity/global-connections :default-connection)) db-spec))
    (lobos.connectivity/close-global))
  ;; Open a new connection or return the existing one.
  (if (nil? (@lobos.connectivity/global-connections :default-connection))
    ((lobos.connectivity/open-global db-spec) :default-connection)
    (@lobos.connectivity/global-connections :default-connection)))
 
(def db
  (merge {:classname "org.postgresql.Driver"
          :subprotocol "postgresql"
          :subname "//localhost:5432/px"}
         (heroku-db)))
 
(open-global-when-necessary db)

After you push to Heroku, you can run heroku run lein repl, load lobos.config and run the migrations just as if they were local.
