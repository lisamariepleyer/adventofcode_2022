# -*- coding: utf-8 -*-

### DAY 6

## PART 1

signal = list()

with open(r"data.txt", "r") as f:
    for line in f:
        for letter in line:
            signal.append(letter)

def findMarker(markerLength):

    firstMarker = 0

    i = markerLength
    while(firstMarker == 0):
        if len(set(signal[(i-markerLength):i])) == markerLength:
            firstMarker = i
        else:
            i += 1

    return(firstMarker)

markerLength = 4
print(f"{findMarker(markerLength)} characters need to be processed before the first start-of-packet marker.")


## PART 2

markerLength = 14
print(f"{findMarker(markerLength)} characters need to be processed before the first start-of-packet marker.")
