library(data.table)

### DAY 2

## PART 1

data <- fread("data.txt", header = F, col.names = c("opponent", "me"))

winning <- data.table(
  op = c("A", "B", "C"),
  me = c("Y", "Z", "X")
)

draw <- data.table(
  op = c("A", "B", "C"),
  me = c("X", "Y", "Z")
)

hand.score <- data.table(
  me = c("X", "Y", "Z"),
  score = c(1, 2, 3)
)

wins <- apply(data, 1, paste, collapse = "_") %in% apply(winning, 1, paste, collapse = "_")
draws <- apply(data, 1, paste, collapse = "_") %in% apply(draw, 1, paste, collapse = "_")

cat("If my strategy was correct, my total score would be ",
    sum(draws)*3 + sum(wins)*6 + sum(merge(hand.score, data)$score),
    ".\n",
    sep = "")


## PART 2

data <- fread("data.txt", header = F, col.names = c("opponent", "outcome"))

losing <- data.table(
  op = c("A", "B", "C"),
  me = c("Z", "X", "Y")
)

setkey(hand.score, "me")
setkey(winning, "op")
setkey(draw, "op")
setkey(losing, "op")

cat("If the elf's strategy was correct, my total score would be ",
    sum(c(hand.score[losing[data[outcome == "X", opponent]]$me, score], 
          hand.score[draw[data[outcome == "Y", opponent]]$me, score] + 3, 
          hand.score[winning[data[outcome == "Z", opponent]]$me, score] + 6)),
    ".\n",
    sep = "")


