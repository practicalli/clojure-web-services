# Clojure Webapps, Practical.li

![Clojure logo](images/clojure-practicalli-banner.png)

  This is an introduce to developing server-side web applications using the Clojure programming language.  The aim is to present Clojure in a simple to understand and highly practical way for developers of any of experience.

  This workshop guides you through the basics of server-side web development and helps you understand the modular approach to using Clojure effectively.  Along the way the relevant functions and design approaches common in Clojure will be highlighted.

## Requirements 

You will need the following in order to complete this workshop.  The [setup](/setup/) contains details on how to get your environment ready

  * A working Java runtime environment (JRE) - test with `java -version` in a command line window
  * [Leiningen](http://leiningen.org/) - test with `lein version` in a command line window
  * A Clojure aware editor with REPL
    - [LightTable](http://lighttable.com/)
    - [Emacs](http://www.gnu.org/software/emacs/) with either [Spacemacs](https://github.com/syl20bnr/spacemacs) or [CIDER](https://github.com/clojure-emacs/cider)
  * A [Git client](http://git-scm.com/) (optional)
  * [A free Heroku account](http://heroku.com) for running Postgres database (alternatively install Posgtres database on your laptop)


## Code for the workshop

The code for this workshop is contained in the Github repository [Clojure Webapps example](https://github.com/practicalli/clojure-webapps-example), the code for each section is in a specific branch.

To get a copy of the repository, use the following git clone command which creates a new directory called clojure-webapps-example that contains the cloned code. 

`git clone https://github.com/practicalli/clojure-webapps-example.git`

Once you have the repository, use `git checkout branch-name` to get the code for each section.  Each branch is a working application with all the features covered in that section

Use `git branch` to show all the branches available, they should match the names of the sections in this workshop.

Enjoy.

## Additional Resources

Here are some resources outside of this workshop that can help you learn more about Clojure

**Getting Started**
* [Clojure through code](https://github.com/practicalli/clojure-through-code/tree/drafts) - many examples of basic Clojure code
* [Getting started with Clojure](http://jr0cket.co.uk/slides/getting-started-with-clojure.html) - a general guide to Clojure (work in progress)
* [4Clojure](https://www.4clojure.com/) exercises & [4Clojure Google group](https://groups.google.com/forum/#!forum/4clojure)
* [Lighttable Koans](https://github.com/practicalli/lighttable-koans) - exercises to help you discover Clojure 
* [Getting started with Clojure on Heroku](https://github.com/jr0cket/clojure-getting-started)

**Clojure**
* [Clojure.org](http://clojure.org), [features](http://clojure.org/features) and [rational](http://clojure.org/rationale)
* [Clojure documentation](http://clojure.org/documentation)
* [Clojure cheetsheet](http://clojure.org/cheatsheet)
* [Official Google group](https://groups.google.com/forum/#!forum/clojure)
* [CrossClj](http://crossclj.info/) - cross-referencing the Clojure ecosystem

**Tooling**
* [Leiningen](http://leiningen.org/), [tutorial](https://github.com/technomancy/leiningen/blob/stable/doc/TUTORIAL.md), [faq](https://github.com/technomancy/leiningen/blob/stable/doc/FAQ.md), [plugins list](https://github.com/technomancy/leiningen/wiki/Plugins) & [sample project file](https://github.com/technomancy/leiningen/blob/stable/sample.project.clj)
* [Spacemacs](https://github.com/syl20bnr/spacemacs)
* [LightTable](http://lighttable.com/), [docs](http://docs.lighttable.com/), [blog](http://www.lighttable.com/blog/), [announcements](https://groups.google.com/forum/#!forum/light-table) and [discussions](https://groups.google.com/forum/#!forum/light-table-discussion).

**Community**
* [Clojure-docs](http://clojure-doc.org/) - community docs 
* [CrossCLJ](http://crossclj.info/) - cross-referencing the Clojure ecosystem
* [London Clojurians](http://www.londonclojurians.org) and their [Google group](https://groups.google.com/forum/#!forum/london-clojurians)
* [Uncle Bob presents Clojure](https://www.youtube.com/watch?v=SYeDxWKftfA)

**Books & Tutorials**
* [Living Clojure](http://shop.oreilly.com/product/0636920034292.do)
* [Clojure cookbook](https://github.com/clojure-cookbook/clojure-cookbook)
* [Brave Clojure](http://www.braveclojure.com/) - a Clojure tutorial using Emacs

**Database** 
* [Testing databases faster - using rollbacks](http://www.lispcast.com/clojure-database-test-faster)

<br />

| Author | Last update |
| -- | -- |
|John Stevenson | Fri 24 March 2016 |
