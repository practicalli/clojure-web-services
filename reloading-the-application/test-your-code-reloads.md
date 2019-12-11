# Test the wrap-reload middleware

  Make a change to the `welcome` function code and check that it automatically reloads.

> ####Note::Run the reloading webserver again.
> If your server is still running, kill it first using `Ctrl-c` keyboard shortcut.  Then run the server again, this time with the new code using the same command as before:
>
```bash
lein run 8000
```

  When you make changes to the `welcome` function you should no longer need to restart your server (unless you manage to crash Jetty).


> ####Hint:: Adding Libraries requires a restart
> You still need to restart the server if you change the main function or add dependencies (librarires) to your project.

---

> ####Note::Change the default response text
> Open your app in the browser http://localhost:8000.
>
> Make a change to the code in the `welcome` function, alterning the text of the body in the default request.

```clojure
(defn welcome
  "A function to process all requests for the web server.  If a request is for something other than / then an error message is returned"
  [request]
  (if (= "/" (:uri request))
    {:status 200
     :body "<h1>Hello, Clojure World</h1>
            <p>Welcome to your first Clojure app, I now update automatically</p>"
     :headers {}}
    {:status 404
     :body "<h1>This is not the page you are looking for</h1>
            <p>Sorry, the page you requested was not found!></p>"
     :headers {}}))
```

  Save the code change and refresh your browser, you should now see the updated message.
