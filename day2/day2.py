# -*- coding: utf-8 -*-

### DAY 2

## PART 1

def getScoreUsingSign(me, opponent):
    match me:
        case "X":
            winning = "C"
            draw = "A"
            losing = "B"
            score = 1
        case "Y":
            winning = "A"
            draw = "B"
            losing = "C"
            score = 2
        case "Z":
            winning = "B"
            draw = "C"
            losing = "A"
            score = 3

    if opponent == winning:
        score += 6
    elif opponent == draw:
        score += 3
    elif opponent == losing:
        score

    return(score)

with open(r"data.txt", "r") as f:
    scores = 0
    for line in f:
        opponent = line.split(" ")[0]
        me = line.split(" ")[1].split("\n")[0]

        scores += getScoreUsingSign(me, opponent)

print(f"If my strategy was correct, my total score would be {scores}.")


## PART 2

def getScoreUsingOutcome(outcome, opponent):
    match opponent:
        case "A":
            winning = "Y"
            draw = "X"
            losing = "Z"
        case "B":
            winning = "Z"
            draw = "Y"
            losing = "X"
        case "C":
            winning = "X"
            draw = "Z"
            losing = "Y"

    match outcome:
        case "X":
            score = getScoreUsingSign(losing, opponent)
        case "Y":
            score = getScoreUsingSign(draw, opponent)
        case "Z":
            score = getScoreUsingSign(winning, opponent)

    return(score)

with open(r"data.txt", "r") as f:
    scores = 0
    for line in f:
        opponent = line.split(" ")[0]
        outcome = line.split(" ")[1].split("\n")[0]

        scores += getScoreUsingOutcome(outcome, opponent)

print(f"If the elf's strategy was correct, my total score would be {scores}.")