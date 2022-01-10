# Create a project

Create a project called `todo-list` using Leiningen, the build automation tool for Clojure.  This project will run the simplest possible webserver.

On the command line:

```bash
lein new todo-list
```

![Leiningen - new project called todo-list](../images/lein-new-todo-list.png)


## Take a look at the project structure

Change into the `todo-list` directory created by the Leiningen command and see the project structure that has been created.

  * `project.clj` - the project definition, written in Clojure
  * `src` for all the source code
  * `test` for unit test code

Using the `tree` command is a simple way to see the project structure (alternatively use `ls -R` or a graphical file browser).

![Clojure project structure - webdev](/images/project-todo-list-tree.png)


> ####Hint:: File names and the Java class path
> The `src` and `test` directories both contain a directory named `todo_list` even though our project is `todo-list`.
>
> Unfortunately the Java classpath does not like dashes '-' in directory or file names, so Leiningen changes the directory names to `src/todo_list` & `test/todo_list` and the initial test to `src/todo_list/core_test.clj`.
