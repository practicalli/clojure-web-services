# Defining Scores and a Scoreboard

We use the Plumatic schema to define what a score looks like, as well as what the overall scoreboard looks like.

## Scores

A score is an whole number (Integer) that represents the score achieved for a particular game

```clojure
(schema/defschema Score
  {:player-id   schema/Uuid
   :score       schema/Int

   (schema/optional-key
     :gravitar) schema/Str})
```

## Leaderboard

The Leader board is a collection of scores for a game.  The scoreboard is ordered by highest value by default.





## Player


## Player accounts
