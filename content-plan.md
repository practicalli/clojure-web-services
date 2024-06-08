# Content plan for Clojure WebApps book
Thanks to the support from Clojurists Together the Clojure WebApps book is being updated to add more content and cover more libraries.

Content will also move to using Clojure CLI tools and deps.edn projects, although the Leiningen content will remain available.

## Proposed content topics for the book update

| Topics                       | Related projects and implementations                                                    |
|------------------------------|-----------------------------------------------------------------------------------------|
| Fundamentals                 | ring and compojure based web applications, covering routing, handlers, middleware, etc. |
| Building API's               | compojure-api template, openapi (swagger), prismatic schema, transit, jsonista          |
| Consuming API's              | clojure.data.* , edn, transit, jsonista                                                 |
| HTML content and templates   | Hiccup and Selmer                                                                       |
| Web Scraping                 | Enilve and clojure.data.*                                                               |
| Full Stack apps              | Luminus template, ClojureScript UI,                                                     |
| Data access                  | jdbc.next, migrations,                                                                  |
| WebSockets                   |                                                                                         |
| High Performance             | http-kit                                                                                |
| Alternative libraries        | Yada, Bidi, Reitit                                                                      |
| Component Lifecycle          | mount, component, integrant, roll your own                                              |
| Data Oriented service design | Reitit, Duct, Edge                                                                      |
| UI design and styling        | CSS libraries (bulma, bootstrap, foundation), SVG graphics                              |


## Project ideas

[Ideas for projects to implement](https://github.com/practicalli/clojure-webapps-content/issues) are most welcome

* Dependency graph using SVG graphics
* TODO:  Kanban application
* Status monitor (SVG Graphics)
* User Management website (demonstrating how to make this usable for other projects)
* Content API for video (targeted searching for finding very specific content on YouTube)
* Financial services API's - online banking, personal insurance, stock tracking (mock stocks)
* API's for a mobile application - Scoreboards, chat boards, rewards, profiles, evil chat bots
