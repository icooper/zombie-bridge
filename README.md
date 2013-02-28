# Zombie Bridge Puzzle

## Problem

After one of our pet projects at the DOD went wrong, we accidentally
triggered the zombie apocalypse. Zombies are particularly slow in
hilly terrain, so you and your fellow survivors figure Marin is
probable the safest spot to be. To get there, all _N_ survivors have to
cross a particular bridge. Unfortunately you only brought one
chainsaw, and crossing bridges without chainsaws is highly inadvisable
during zombie attacks. Due to unrelated events, the bridge is also
close to collapsing, and at most two people can safely cross the
bridge at a time.

To make things more complicated, everybody needs a different time to
cross the bridge. And running away from zombies is extremely
fatiguing, so after each crossing of the bridge the time somebody
needs to cross increases by 20%, while each minute of rest reduces the
time somebody needs to cross by 5 seconds (until it reaches the
person's initial value again). If two people are traveling together,
the speed of the two is the speed of the slower survivor.

Your task is to find a strategy that minimizes the time needed by the
entire group. Your input will be a file with _N_ lines, each giving you
the number of minutes a person needs to cross the bridge, e.g. for a
group of 6 survivors:

    20
    15
    18
    27
    12
    30

Your program should return the total time your solution needs and the
strategy in the following format

    -> 0 1 (20)
    <- 0 (18)
    -> 2 4 (18)
    <- 1 4 (21)
    ...
    642

Meaning that in the first crossing, Survivors 0 and 1 (indexing starts
at 0) cross the bridge towards Marin and need 20 minutes. 1 keeps the
chainsaw and returns to the Peninsula, but due to fatigue needs 18
minutes (15 + 20%) now. He passes your weapon of choice to 2 and 4,
which cross the bridge in 18 minutes. 4 keeps the chain saw and
returns together with 1. 4 would need 14.4 minutes to return now, but
is slowed down by 0 who needs 21 minutes (20 * 1.2 = 24 min, then 36
minutes of rest = 180 seconds recovered, 24 - 180/60 = 21), and so on.
The last line of the output should be the total time required by your
strategy to get all survivors across the bridge.

## Solution

See @puzzle.coffee@.