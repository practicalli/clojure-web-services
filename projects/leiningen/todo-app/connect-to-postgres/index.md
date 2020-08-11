# Connecting to Heroku PostgreSQL from Clojure	

* Add dependencies 
* Define a database connection (Heroku posgres)
* Migrations 
  * Create a database table if it doesnt exist

???


## Using JDBC for Relational Databases 

Java Database connnectivity is a common way to connect to a relational database and has very widespread database support.  

Clojure developers typically send SQL statements over jdbc or use a DSL such as [Korma]()) to work with these databases.  In our example we will work with SQL statements [TODO: add Korma as an alternative, add some experiences as to when to do either approach]

