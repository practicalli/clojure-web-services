

get-connection requires that provided URIs be structured like so:

dbtype://user:password@host:port/database

This is often sufficient, but many PostgreSQL URIs require the use of URI parameters to further configure connections. For example, postgresql.heroku.com provides JDBC URIs like this:

jdbc:postgresql://ec2-22-11-231-117.compute-1.amazonaws.com:5432/d1kuttup5cbafl6?user=pcgoxvmssqabye&password=PFZXtxaLFhIX-nCA0Vi4UbJ6lH&ssl=true

...which, when used outside of Heroku's network, require a further sslfactory=org.postgresql.ssl.NonValidatingFactory parameter.

The PostgreSQL JDBC driver supports a number of different URI parameters, and recommends putting credentials into parameters rather than using the user:password@ convention. Peeking over at the Oracle thin JDBC driver's docs, it appears that it expects credentials using its own idiosyncratic convention, user/password@.

<opinion>
This all leads me to think that get-connection should pass URIs along to DriverManager without modification, and leave URI format conventions up to the drivers involved. For now, my workaround is to do essentially that, using a map like this as input to with-connection et al.:

{:factory #(DriverManager/getConnection (:url %))
 :url "jdbc:postgresql://ec2-22-11-231-117.compute-1.amazonaws.com:5432/d1kuttup5cbafl6?user=pcgoxvmssqabye&password=PFZXtxaLFhIX-nCA0Vi4UbJ6lH&ssl=true"}

That certainly works, but I presume that such a workaround won't occur to many users, despite the docs/source.
</opinion>

I don't think I've used java.jdbc enough (or RDMBS' enough of late) to comfortably provide a patch (or feel particularly confident in the suggestion above). Hopefully the report is helpful in any case.
Activity

    All
    Comments
    History
    Activity

Sean Corfield added a comment - 14/Jun/12 1:36 AM - edited

How about an option that takes a map like:

{:connection-uri "jdbc:postgresql://ec2-22-11-231-117.compute-1.amazonaws.com:5432/d1kuttup5cbafl6?user=pcgoxvmssqabye&password=PFZXtxaLFhIX-nCA0Vi4UbJ6lH&ssl=true"}

Essentially as a shorthand for the workaround you've come up with?
Sean Corfield added a comment - 15/Jun/12 10:20 PM

Try 0.2.3-SNAPSHOT which has support for :connection-uri and let me know if that is a reasonable solution for you?
Chas Emerick added a comment - 18/Jun/12 3:35 PM

Yup, 0.2.3-SNAPSHOT's :connection-uri works fine. I've since moved on to using a pooled datasource, but this will hopefully be a more obvious path to newcomers than having to learn about :factory and DriverManager.
Sean Corfield added a comment - 18/Jun/12 3:52 PM

Resolved by adding :connection-uri option.
Carlos Cunha added a comment - 28/Jul/12 8:09 PM

accessing an heroku database outside heroku, "sslfactory=org.postgresql.ssl.NonValidatingFactory" doesn't work. i get "ERROR: syntax error at or near "user" Position: 13 - (class org.postgresql.util.PSQLException". this happens whether adding it to :subname or :connection-uri Strings

another minor issue - why the documentation of "with-connection" (0.2.3) refers the following format for the connection string URI:
"subprotocol://user:password@host:post/subname
An optional prefix of jdbc: is allowed."
but the URI which can actually be parsed successfully is like the one above: jdbc:postgresql://ec2-22-11-231-117.compute-1.amazonaws.com:5432/d1kuttup5cbafl6?user=pcgoxvmssqabye&password=PFZXtxaLFhIX-nCA0Vi4UbJ6lH&ssl=true
"subprotocol://user:password@host:post/subname" (format like the DATABASE environment variables on heroku) will not be parsed correctly. why the format for the URI that is used on heroku is not supported by the parser?

maybe i'm doing something wrong here

thanks in advance
Sean Corfield added a comment - 29/Jul/12 4:57 PM

Carlos, the :connection-uri passes the string directly to the driver with no parsing. The exception you're seeing is coming from inside the PostgreSQL driver so you'll have to consult the documentation for the driver.

The three "URI" styles accepted by java.jdbc are:

    :connection-uri - passed directly to the driver with no parsing or other logic in java.jdbc,
    :uri - a pre-parsed Java URI object,
    a string literal - any optional "jdbc:" prefix is ignored, then the string is parsed by logic in java.jdbc, based on the pattern shown (subprotocol://user:password@host:port/subname).

If you're using :connection-uri (which is used on its own), you're dealing with the JDBC driver directly.

If you're using :uri or a bare string literal, you're dealing with java.jdbc's parsing (implemented by Phil Hagelberg - of Heroku).

Hope that clarifies?
Carlos Cunha added a comment - 29/Jul/12 8:36 PM

Sean, thank you for such comprehensive explanation.

Still, it didn't work with any of the options. I used before a postgres JDBC driver to export to the same database (in an SQL modeller - SQLEditor for the MAC) and it worked (though it would connect some times, but others not). The connection String used was like "jdbc:postgresql://host:port/database?user=xxx&password=yyy&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory". The driver name was "org.postgresql.Driver" (JDBC4). Anyway, time to give up. I will just use a local database.

Thank you!
Carlos Cunha added a comment - 31/Jul/12 7:20 PM

Sean, JDBC combinations were working after. i was neglecting an insert operation in a table with a reserved sql keyword "user", so i was getting a "ERROR: syntax error at or near "user" Position: 13", and therefore the connection was already established at the time.

i'm sorry for all the trouble answering the question (_

thank you
Sean Corfield added a comment - 31/Jul/12 7:46 PM

Glad you got to the bottom of it and confirmed that it wasn't a problem in java.jdbc!
