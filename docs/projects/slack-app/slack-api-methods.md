# Slack API Methods

An access token allows the calling of the methods described by the scopes requested during a Slack App installation,
e.g., the chat:write scope allows an app to post messages. 

The app isn't a member of any channels when installed.  Choose a channel suitable for testing purposes and `/invite` the Slack app to the channel.

You can find the corresponding id for the channel that your app just joined by looking through the results of the conversations.list method:

```shell
curl https://slack.com/api/conversations.list -H "Authorization: Bearer xoxb-1234..."
```

You'll receive a list of conversation objects.

Now, post a message to the same channel your app just joined with the chat.postMessage method:

```shell
curl -X POST -F channel=C1234 -F text="Reminder: we've got a softball game tonight!" https://slack.com/api/chat.postMessage -H "Authorization: Bearer xoxb-1234..."
```

![Slack Web UI - Web API Methods search](https://github.com/practicalli/graphic-design/blob/live/clojure-web-services/slack-app/slack-app-api-settings-add-app-to-workspace-allow.png?raw=true#only-dark#){loading=lazy}


Voila! We're already well on our way to putting a full-fledged Slack app on the table.

[Web API Guide](https://api.slack.com/web)

[API Methods list](https://api.slack.com/methods)

[Interactive Workflows](https://api.slack.com/interactivity)

