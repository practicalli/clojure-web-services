# Run project

The compojure template provides a working webserver and simple webapp out of the box.

> ####Note:: Run the project to start the server and webapp

```shell
lein ring server
```

If you have not used Compojure or Ring previously, then it may take a few seconds to download their libraries from the Internet before starting the Jetty web server.

You should see a output after the leiningen command showing you that the server has started

```shell
2016-07-15 13:44:02.242:INFO:oejs.Server:jetty-7.6.13.v20130916
2016-07-15 13:44:02.313:INFO:oejs.AbstractConnector:Started SelectChannelConnector@0.0.0.0:3000
Started server on port 3000
```

Your default browswer should also open at http://localhost:3000 with a message saying "Hello World".  If your browser does not open then check for errors in the terminal where you ran the leiningen command.
