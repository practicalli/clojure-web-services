# Slack Scopes Overview

Scopes give the app permission to carry out actions, e.g. post messages, in the development workspace.

Open the development workspace, either in a web page or in the Slack desktop app.

**Sidebar** > **OAuth & Permissions** > **Scopes** > **Add an OAuth Scope**

- `chat:write` scope to the Bot Token to allow the app to post messages
- `channels:read` scope too so your app can gain knowledge about public Slack channels
- `commands` scope to build a Slash command. 
- `incoming-webhook` scope to use Incoming Webhooks. 
- `chat:write.public` scope to gain the ability to post in all public channels, without joining. Otherwise, you'll need to use conversations.join, or have your app invited by a user into a channel, before you can post.
- `chat:write.customize` scope to adjust the app's message authorship to make use of the username, icon_url, and icon_emoji parameters in `chat.postMessage`.


> Add scopes to the Bot Token. 
> 
> Only add scopes to the User Token when the app needs to act as a specific user (e.g. post message as user, set user status, etc.)


If the scopes applied to a Slack App are changed, the Slack App must be redeployed to the workspace (and Slack App Directory) for the changes to take effect.

![Slack Web UI - Warning changed slack app permission scopes - reinstall the app](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-app-settings-oauth-scopes-reinstall-warning.png?raw=true#only-dark#){loading=lazy}


