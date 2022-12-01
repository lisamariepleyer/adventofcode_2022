# -*- coding: utf-8 -*-

### DAY 1

## PART 1

with open(r"data.txt", "r") as f:
    calories = list()
    elfCalories = 0
    
    for line in f:
        if line == "\n":
            calories.append(elfCalories)
            elfCalories = 0
        else:
            elfCalories += int(line.strip())

print(f"The elf that is carrying the most calories is carrying {max(calories)} calories.")


## PART 2

calories.sort(reverse=True)

print(f"The top three elves are carrying a total of {sum(calories[0:3])} calories.")
