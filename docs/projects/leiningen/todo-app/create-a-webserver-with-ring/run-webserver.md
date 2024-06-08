# Run webserver

Run the webserver we use Leiningen, the Clojure build automation tool.

## Run the webserver

In a command line terminal, navigate to the root of your project and type the following command

```bash
lein run 8000
```

This command will start an embedded Jetty web server that listens on http://localhost:8000.

![Todo list project - lein run with port number](../images/todo-list-lein-run-portnumber.png)

Open http://localhost:8000 in your browser and try out different pages, such at [http://localhost:8000/hello]( http://localhost:8000/hello),  [/goodbye]( http://localhost:8000/goodbye) or  [/makes-no-difference]( http://localhost:8000/makes-no-difference).  It should not matter what page you visit, you should get the same response.

![todo-list project in the browser](../images/todo-list-lein-run-browser.png)

To stop the server, press **Control-c** in the terminal used to run the lein command.
