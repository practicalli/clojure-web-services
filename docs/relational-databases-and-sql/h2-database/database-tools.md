# Database tools
[DBeaver](https://dbeaver.io/) is a free database tool that supports the H2 database and many other databases.

## Create a new connection
Create a **New Connection** and select **Embedded > H2 database**

Select a `*.mv.db file` as the path

![DBeaver database tool - Embedded H2 database connection](/images/dbeaver-h2-new-connection-banking-on-clojure.png)

If the H2 driver is not installed in DBeaver, a will prompt will display to download it.

![DBeaver database tool - H2 database driver download](/images/dbeaver-h2-driver-download.png)

Expand the connection to see the schema details

![DBeaver database tool - Embedded H2 database connection](/images/dbeaver-h2-connection-schema-details.png)

## H2 database single connection
When connecting to the H2 database using a database management tool such  ad DBeaver, the database is locked and prevents code from running in the REPL.

![Clojure WebApps - H2 Database error - file lock](/images/clojure-webapps-database-h2-error-locked-database-file.png)

Close the connection in the database management tool to continue using the REPL.
