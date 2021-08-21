## Batching queries

using next.jdbc and am doing a batch insert using next.jdbc.prepare/execute-batch!It is working as expected but then following the instructions here https://cljdoc.org/d/seancorfield/next.jdbc/1.1.569/doc/getting-started/prepared-statements#batched-parameters
I and trying to use .getGeneratedKeys to get the results set back and it only returns the last batch to be inserted not the entire set.
Is this expected behaviour? (edited)
sofra  05:59
I sort of understand why, it is stateful and .getGeneratedKeys would need to be called in between each call to .executeBatch?
seancorfield  06:05
@sofra Yeah, it's a bit of an edge case. Different databases behave differently on this, unfortunately.
sofra  06:05
:thumbsup:
seancorfield  06:05
Some databases will return all generated keys (from all batches executed), some don't return any keys at all.
sofra  06:06
Thanks @seancorfield, makes sense
seancorfield  06:07
(hence all the caveats on that page :slightly_smiling_face: )
06:10
How big is the batch you're inserting @sofra?
seancorfield  06:16
If it's large enough to cause multiple .executeBatch calls, I can understand you only getting one set of keys back. I guess I could modify execute-batch! so that if :return-keys is truthy, it could attempt to call .getGeneratedKeys each time internally and return the result sets joined together. It seems like a reasonable enhancement, although I'd need to ensure it doesn't break existing behavior (so, probably another option as well as :return-keys I suspect).
06:18
https://github.com/seancorfield/next-jdbc/issues/133 (edited)
sofra  06:25
@seancorfield it is a few thousand rows. Thanks for the info. I can work around it now I understand. Sounds like a reasonable enhancement to me too.
seancorfield  06:35
@sofra Are you specifying the :batch-size option to execute-batch! or just letting it do its thing?
sofra  06:36
yeah I was specifying it
seancorfield  06:36
If you don't specify it, .executeBatch will only be called once and .getGeneratedKeys should return all the keys -- but that may too much data for a single batch.
06:37
Anyway, I'll add that enhancement probably this week and put out a new release by the end of next weekend at the latest.
sofra  06:42
Thanks @seancorfield I was batching since it was too much for a regular mutli-insert! and the db was throwing errors. That is why I figured I would need to set :batch-size but I didn’t actually test that assumption.
