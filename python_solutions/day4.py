# -*- coding: utf-8 -*-

### DAY 4

import sys

data = [arg for arg in sys.argv[1:] if not arg.startswith("-")][0]

## PART 1

def elfRange(endpoints):
    enpoints = endpoints.split("-")
    enpoints = [eval(i) for i in enpoints]
    listRange = list(range(enpoints[0], enpoints[1]+1))
    return(listRange)

with open(data, "r") as f:
    areContainedInOther = 0

    for line in f:
        line = line.strip().split(",")

        elfOne = elfRange(line[0])
        elfTwo = elfRange(line[1])

        overlaps = set(elfOne).intersection(elfTwo)

        if len(overlaps) == len(elfOne) or len(overlaps) == len(elfTwo):
            areContainedInOther += 1

print(f"In {areContainedInOther} pairs one range is fully contained in the other.")


## PART 2

with open(data, "r") as f:
    areOverlapping = 0

    for line in f:
        line = line.strip().split(",")

        elfOne = elfRange(line[0])
        elfTwo = elfRange(line[1])

        overlaps = set(elfOne).intersection(elfTwo)

        if len(overlaps) > 0:
            areOverlapping += 1

print(f"In {areOverlapping} pairs the two ranges overlap.")
