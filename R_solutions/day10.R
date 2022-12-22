### DAY 10

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

X <- 1

for (cmd in data) {
  if (cmd == "noop") {
    X <- c(X, X[length(X)])
  } else {
    X <- c(X, X[length(X)])
    X <- c(X, X[length(X)] + as.integer(strsplit(cmd, split = " ")[[1]][2]))
  }
}

cat("The sum of the six signal strengths is ",
    sum(X[seq(20, 220, 40)] * seq(20, 220, 40)),
    ".\n",
    sep = "")


## PART 2

cat("The letters are:\n\n")

for (cycle in 1:length(X)) {
  
  sprite <- cycle %% 40
  if (sprite == 0) {
    sprite <- 40
  }
  
  if(sprite %in% X[cycle]:(X[cycle]+2)) {
    cat("#")
  } else {
    cat(".")
  }
  if (cycle %in% seq(0, 240, 40)) {
    cat("\n")
  }
}

