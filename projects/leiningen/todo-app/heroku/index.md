# Deploying to Heroku

Heroku is a developer-focused Platform as a Service, using the tools developers know well.  You can simply push your projects to Heroku using Git and your application is deployed for you automatically.

* Create a [free Heroku account](https://heroku.com)
* Download the [Heroku Toolbelt](https://toolbelt.heroku.com)

## Identify your laptop to Heroku

To be able to deploy your app to Heroku, you first need establish a trusted connection between your laptop and Heroku.  Run the following command (from the Heroku Toolbelt)

```bash
heroku login
```

Enter your username and password for Heroku.  Also enter your 2-factor authorisation code if you enabled that on your Heroku account.

Credentials are cached so `heroku login` should only need to be run once per computer and user account.
