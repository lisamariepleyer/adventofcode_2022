# -*- coding: utf-8 -*-
import string
from itertools import chain
import sys

data = [arg for arg in sys.argv[1:] if not arg.startswith("-")][0]

### DAY 3

## PART 1

priority = list(chain.from_iterable([
    list(string.ascii_lowercase),
    list(string.ascii_uppercase)
]))

with open(data, "r") as f:
    valueCommonItems = 0

    for line in f:
        compartmentOne, compartmentTwo = line[:len(line)//2], line[len(line)//2:]
        valueCommonItems += priority.index(''.join(set(compartmentOne).intersection(compartmentTwo))) + 1

print(f"The sum of the misplaced item types of all rucksacks is {valueCommonItems}.")


## PART 2

groupSize = 3

with open(data, "r") as f:
    allRucksacks = list()
    valueCommonItems = 0

    for line in f:
        allRucksacks.append(line.strip())

    allRucksacks = [allRucksacks[i:i+3] for i in range(0, len(allRucksacks), 3)]

    for groupRucksack in allRucksacks:
        valueCommonItems += priority.index(''.join(set.intersection(*map(set, groupRucksack)))) + 1

print(f"The sum of the item types shared between groups is {valueCommonItems}.")
