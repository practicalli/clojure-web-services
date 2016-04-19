# Deploy to Heroku

First we need to create an Heroku app to deploy our Clojure webapp to.  This adds a remote repository we can push our code to using Git.

> **Note** Create an Heroku app using the Heroku dashboard or using the following Heroku toolbelt command

In a command line terminal, navigate to the root of your project (where your `project.clj` file is)

```bash
heroku create
```

If we have changes in our source code files, then we should first add and then commit them to our local repository.

```bash 
git add .
git commit -m "meaningful commit message"
```

Now push the Clojure webapp code to Heroku and wait a few moments for it to deploy

```
git push heroku master
```

