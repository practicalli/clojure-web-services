# Cme to make up for it.  Testing & experimenting at the REPL are greatly facilitated by this approach.

Not saying it’s the best or only way to do it, and keen to hear of better alternatives folks have come up with! (edited)

    and the state (connections or whatever) get passed in as vanilla fn arguments to those logic fns

when switching from spring this is the hardest part to unlearn, since, as a spring developer you always have this feeling that something is @Autowired into something else (because it is in spring), and when switching to functional languages (about 12 years ago) it took me awhile to not have functions wrap that state.whether you keep your states separately or with is more of a personal preferences (both work well). things to watch out are circular dependencies and keeping those states as thin and low level as possible. I tend to keep a state with its logical module: i.e. "system-a" namespace will have a connection to "system a" plus some functions to work with "system a". but again, the main thing is to design functions in a way that they do not wrap state: i.e. take all the state they need as args.

    It can get a bit unwieldy when you have a logic fn that depends on a lot of different state

these (potentially) could be good candidates to refactor into several functions and compose them at the edges of the application

I try to write “pure” namespaces focused on providing fns that do one thing and one thing well, and then compose those together somewhere else, alongside all the state (often a “core” namespace). (edited)

    I tend to keep a state with its logical module: i.e. “system-a” namespace will have a connection to “system a” plus some functions to work with “system a”.

does it mean that you declare the state and the functions that depend on it in the same namespace (file)? and if this is the case, it wouldn’t be necessary to pass the state as fns arguments, since they can just use the state directly. (edited)




i’m having problems with ending up in a DerefableState {:status :pending, :val nil} when loading my state from a file using io/file. Am I trying to access the resource too soon or am I thinking of this wrong? Logging says that my defstate gets started but if I remove the places accessing the state, I can load the namespace in repl and it has the value I’m expecting. How can I get the state properly initialized?

    does it mean that you declare the state and the functions that depend on it in the same namespace (file)? and if this is the case, it wouldn’t be necessary to pass the state as fns arguments, since they can just use the state directly.

the location of state should not really affect the function design. a function would usually take all the state / args it needs. it makes it "self contained" which allows for better testing, refactoring, reuse, .. all the good things. (edited)

an example. usually a couple of quick things to look out for:

    call mount/start in case state needs to be created before the function is called

and / or

    to make sure that compiler sees the namespace where the state lives: i.e. (require '[foo.bar]) where state component lives.

if I’ve got states A and B, A uses B in its start, when I start state A, state B doesn’t get started… what is the reason for that?


you can start all with (mount/start) or you can do (mount/start #'foo/a #'foo/b)
when you start a state individually (mount/start #'foo/a) it only focuses on a state specified and does not affect other states


so if I want to start the web server, but not scheduled jobs for instance, I have to manually list all the dependencies?

you can start all except  a "scheduler" state: https://github.com/tolitius/mount#composing-states (edited)
or if you don't need to compose them: https://github.com/tolitius/mount#start-an-application-without-certain-states (edited)

 so need to list scheduler and dependencies that it uses but web server doesn’t use in except
I assume same principle applies, putting just scheduler in except will only skip that one, not it’s dependencies

correct. how many states do you need to exclude?
usually it's from one to just a few, otherwise it might be an indicator to remove number of stateful things
this depends of course, but if states are kept low level (connections, tread pools, listeners, servers, etc..) there are just not as many of them in a given application (edited)


 -->
