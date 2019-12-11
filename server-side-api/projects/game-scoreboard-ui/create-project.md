# Create new project using figwheel-main

Create a new project using figwheel-main, the newest version of figwheel.

Include the `reagent` library to make the project a single page app in the style of react.js.


```shell
lein new figwheel-main game-scoreboard-ui -- --reagent
```

![Game scoreboard new Leiningen project with figwheel-main and reagent](/images/game-scoreboard-ui--leiningen-new-project-figwheel-main.png)


Change into the 'game-scoreboard-ui' directory and run 'lein fig:build'


```shell
cd game-scoreboard-ui
lein fig:build
```

Your default browser will open at [localhost:9500](http://localhost:9500/)


![Game Scoreboard UI - new project website](/images/game-scoreboard-ui--new-project-website.png)
