# Clojure powered Slack Application

Slack applications provide a way to extend the functionality of Slack and provide integration with other services, e.g. GitHub, Atlassian Jira & Confluence, etc.


## Development process Overview

- create a slack account and slack space (to test the application)
- create a slack app 
- deploy the slack app in the slack test workspace created previously
- Create a clojure project and interact with the Slack API
- Setup ngrok domain for Slack app to access a locally running Clojure web service (to respond to interaction with the app - assuming the slack isnt just push driven) 
  - alternatively, webservices connection can be configured between the locally running Clojure app and slack (desktop app required? - how does this work...) 

- deploy clojure application to public cloud (AWS, Render.com, etc)

