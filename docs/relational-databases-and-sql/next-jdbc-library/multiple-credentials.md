## Multiple credentials for database connection

https://clojurians.slack.com/archives/C1Q164V29/p1596219753354000

 For my use case it would be very helpful to allow to call get-connection with username and password in next-jdbc. I would like to propose a patch but am unsure if you would prefer to have username and pw as part of opts or as new arities of get-connection.

Is there a reason for you to not provide :user and :password as part of the hash map passed to get-datasource?

@seancorfield Sure, that's possible. But I am using different users with the same datasource and thought this approach would be cleaner and could help others as well.
seancorfield  19:29
The DataSource object supports (.getConnection ds username password) so you could get your connections that way.
19:29
(and that's true of the reified DataSource that get-datasource produces from a hash map or URL)
strsnd  19:31
Oh yeah. I was already using get-connection. I see, my patch would just be aesthetics then. :wink:
seancorfield  19:31
I understand that's not as convenient so I'll have a think about it. Feel free to create an issue on GitHub.
strsnd  19:32
I will. If you come to a conclusion I am happy to help and provide a patch for that.
seancorfield  19:34
If you use a connection pooled datasource, aren't you restricted to a single user/password (since you have to provide that to c3p0 or HikariCP)? Or do those support connection-level user/password settings?
19:38
Given that I can't change the Connectable protocol without (potentially) breaking existing code, I'd want to pass :user / :password via the opts there (even if next.jdbc/get-connection was updated to have extra arities, it would resolve to (p/get-connection spec opts) under the hood), so then I think the only change would be this line in the private make-connection function would need to check for those keys in the opts:

  (let [^Connection connection (.getConnection datasource)]

would become something like

  (let [^Connection connection (if (and (:user opts) (:password opts)) (.getConnection datasource (:user opts) (:password opts)) (.getConnection datasource))]

^ @strsnd Thoughts?
strsnd  19:39
@seancorfield hikari will throw an Unsupported SQL Exception, c3p0 has different pools for username+password
19:40
The simple PostgreSQL Pool will just open a non-pooled Connection in this case.
seancorfield  19:41
(for the reified DataSource, that arity .getConnection only folds the username and password back into the etc hash map under the hood when calling DriverManager/getConnection anyway)
strsnd  19:43
I am fine with your proposal above, but my first attempt was to add new arities to the functions. We would go from spec and spec opts to spec user pass and spec user pass opts. I am not very experienced with java/clojure backwards "ABI" compatibility, but this change could break external users of the protocols, right?
seancorfield  19:44
Right. I'm not changing the arities in the protocol.
strsnd  19:45
I was writing a bit lengthy github issue talking about exactly this but do we want to continue here and I just submit a basic feature request?
seancorfield  19:46
I'm open to changing the arities in the top-level wrapper (next.jdbc/get-connection) but it would just assoc those into opts and pass that down. I'm just not sure of the value of that, given the narrowness of the use case (either unpooled connection or just c3p0, based on your comments above).
strsnd  19:47
Right, I would also be totally fine with leaving everything as is.
seancorfield  19:51
The change is pretty minor so I might as well go ahead and make it anyway at that level.
strsnd  19:53
I would welcome that! It allows me to continue to use the other options as well that get-connection provides and not having to fall back to a custom wrapper.
seancorfield  19:57
@strsnd Fixed on develop. Let me know how that works for you. I'll probably cut a new next.jdbc release this weekend if you need a published version on clojars?
strsnd  19:58
@strsnd awesome, I can quickly pull it in and give it a test. Will report back in few minutes.
19:58
There is no need to hurry with a release because of me.
seancorfield  19:59
There's already the execute-batch! enhancement pending a release so I was planning an update soon anyway.
strsnd  20:11
@seancorfield Tested and works. Thanks a lot!
noisesmith  20:45
having mixed auth in one pool sounds like a security problem
seancorfield  20:55
I remember reading that c3p0 supported that and thinking "Hmm, I wonder why anyone would do that?" :slightly_smiling_face:
strsnd  22:17
@noisesmith they are distinct pools in c3p0, they are hashed by user+pw, the other pools that don't support it just throw an exception (edited)
22:18
I try to use a ro user most of the time and just for some actions need to elevate
seancorfield  22:30
@strsnd I can understand that. We have separate datasources for r/o vs r/w so it's usually very clear in our code which one is being used where.
