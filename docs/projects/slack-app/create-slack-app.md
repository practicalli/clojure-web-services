# Create Slack App

Create a Slack account and follow the prompts to create a new workspace.  The workspace will be used to deploy the Slack App for testing purposes.

> Use an existing Slack workspace if sufficient administration privelleges are available (and you wont affect other peoples use of Slack)

[Slack Quickstart](https://api.slack.com/start/quickstart) describes how to create a Slack app.

[Create a new Slack app with the Slack UI](https://api.slack.com/apps)

![Slack Web UI - Create an App](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/clojure-web-services-slack-app-your-apps-create-an-app.png?raw=true#only-dark#){loading=lazy}

Select **From Scratch**

![Slack Web UI - create an app options](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/clojure-web-services-slack-app-your-apps-create-an-app--options.png?raw=true#only-dark#){loading=lazy}

Enter App Name and select the Development Workspace to experiment and build the app. 

![Slack Web UI - name app and choose workspace](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/clojure-web-services-slack-app-your-apps-create-an-app--from-scratch-clojure-function-app-name.png
?raw=true#only-dark#){loading=lazy}

> Regardless of development workspace, the app can be distributed to any other workspaces.

The Slack Web UI displays the basic information for the newly created Slack app.

![Slack Web UI - new slack app basic information](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/clojure-web-services-slack-app-manifest-code-config-popup.png?raw=true#only-dark#){loading=lazy}

<!-- TODO: add App Manifest approach to creating a Slack App -->


## Configure scopes

Add a scope to post messages to a channel

**Sidebar** > **OAuth & Permissions** > **Scopes** > **Add an OAuth Scope**

![Slack Web UI - Slack App Scopes](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-app-settings-oauth-scopes.png?raw=true#only-dark#){loading=lazy}

Add the following Bot Token Scopes

- `chat:write` scope to the Bot Token to allow the app to post messages
- `channels:read` scope too so your app can gain knowledge about public Slack channels

![Slack Web UI - Add Bot Token Scopes](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-app-settings-oauth-scopes-chat-write.png?raw=true#only-dark#){loading=lazy}


> Reisntall the app if changing scopes and other features


## Update Display information

> This feels like it should have been done before installing the app

Provide a short & long description of the app and set background colour.  Optionally add an app icon (between 512 and 2000 px in size).

- **Short description**: A random function from the Clojure Standard Library
- **Long description**: A random function is selected from the Clojure Standard Library and displayed along with the documentation (doc string) to explain what the function does. A bonus feature will be to provide examples of function use.


## Install app in workspace

Install your app to your Slack workspace to test it and generate the tokens you need to interact with the Slack API. You will be asked to authorize this app after clicking an install option.

Sidebar > Settings > Basic Information > Install your app

![Slack Web UI - Choose a workspace to deploy the Slack app](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-workspace-sign-in.png?raw=true#only-dark#){loading=lazy}


### Authorization token

The Authorization token for the workspace is in the [app management web page](https://api.slack.com/apps/) for the specific app

**Sidebar** > **OAuth & Permissions** > **OAuth Tokens for Your Workspace**

Create an environment variable to hold the authorization token with the value of the **Bot User OAuth Token**

```shell
export SLACK_AUTHENTICATION_TOKEN=xxxx-123412341234-12345123451245-...   
```

> Environment variables used with Clojure must be set before running the REPL, so the variables are available to the Java Virtual Machine process.
>
> Add the environment variables to `.bashrc` for Bash or `.zshenv` for Zsh


Access tokens represent the permissions delegated to the app by the installing user. 

> Avoid checking access tokens into version control 


## Test app  - save for later...

Add the app to a public channel and test its (as yet unconfigured slash command)

![Slack Web UI - Add Clojure function Slack App to a channel](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-workspace-add-app-to-channel.png?raw=true#only-dark#){loading=lazy}

Confirm the Slack App should be added to the selected workspace

![Slack Web UI - Slack App requesting permission to access the workspace](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-app-api-settings-add-app-to-workspace-allow.png?raw=true#only-dark#){loading=lazy}



## Local Development

Use Socket Mode to route the app interactions and events over a WebSockets connection instead sending payloads to Request URLs, the public HTTP endpoints.

Socket mode is intended for internal apps that are in development or need to be deployed behind a firewall. It is not intended for widely distributed apps. 

Alternatively, use ngrock to redirect requests to the local app.


### Install app into workspace

Install Slack app into a workspace (not the development workspace)

**Sidebar** > **Install App** > **Install App To Workspace** > **Slack OAuth UI**


