# Creating a database model

> #### Hint::TODO: Complete the database model
> The examples in Database model section are not finished, although hopefully you have learned enough to be able to continue working on this for homework.
>
> Please ask questions and share your approaches in the [Practicalli Contact channels](https://practicalli.github.io/#contact)
>
> These examples will be updated to use next.jdbc over Winter 2020


Our tasks are quite simple and so its easy to represent them as a single table

* id (auto-generated)
* name of task
* description of task
* type of task

Each task will have a unqiue ID, automatically generated when a new record is created.

The name, description and type of task are all strings.

> ####Hint:: The type of task could be managed by a second table that lists all the tasks.  However, this is only meant to be a simple app at this stage.



## Namespace design

We need to decide what namespace to put our data model in.  It seems to make sense to create a new namespace, to help keep our code clean and to separate concerns. So we will create a namespace `todo-list.list` namespace.

We will need to decide whether to add the `items` namespace to core or to the handlers... or maybe create another handler namespace for handlers that just access the database

```clojure
(:require [todo-list.items :as items]
```
