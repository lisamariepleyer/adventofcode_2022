library(data.table)

### DAY 11

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

max.rounds <- 20

# PARSE DATA

monkeys <- do.call(rbind, strsplit(data[grep("^Monkey [0-9]", data)], split = ":"))[,1]

parse.input.data <- function () {
  
  # get starting items
  starting.items <- lapply(do.call(rbind, 
                                   strsplit(grep("Starting items: ", data, value=T), 
                                            split = ":"))[,2], 
                           function (x) {
                             as.integer(trimws(strsplit(x, ",")[[1]]))
                           })
  names(starting.items) <- monkeys
  starting.items <<- starting.items
  
  # get worry operations
  operations <- do.call(rbind, 
                        strsplit(do.call(rbind, 
                                         strsplit(grep("Operation: ", data, value=T), 
                                                  split = ":"))[,2], 
                                 split = "= "))[,2]
  names(operations) <- monkeys
  operations <<- operations
  
  # get testing conditions
  tests <- as.integer(do.call(rbind, strsplit(grep("Test: ", data, value=T), split = "by "))[,2])
  names(tests) <- monkeys
  tests <<- tests
  
  # set monkey based on test was fulfilled
  condition <- list(c(T, F))
  condition <- rep(condition, length(monkeys))
  tmp <- paste("Monkey", do.call(rbind, strsplit(grep("If ", data, value=T), split = "monkey "))[,2])
  
  for (i in 1:(length(tmp) / 2)) {
    names(condition[[i]]) <- tmp[((i * 2) - 1) : (i * 2)]
  }
  names(condition) <- monkeys
  condition <<- condition
  
}

# DEFINE GAME RULES

get.worry.level <- function(item, monkey) {
  return(eval(parse(text = gsub("old", item, operations[[monkey]]))))
}

get.next.monkey <- function(worry.level, monkey) {
  return(names(which(condition[[monkey]] == ifelse(worry.level %% tests[[monkey]] == 0, T, F))))
}

touched.items <- data.table(monkey = monkeys,
                            touched = 0)
setkey(touched.items, "monkey")

# LOOP THROUGH ROUNDS

parse.input.data()

for (round in 1:max.rounds) {
  
  for (turn in 0:(length(monkeys)-1)) {
    
    monkey <- paste("Monkey", turn)
    
    touched.items[monkey, touched := touched + length(starting.items[[monkey]])]
    
    for (item in starting.items[[monkey]]) {
      
      worry.level <- get.worry.level(item, monkey)
      worry.level <- floor(worry.level / 3)
      next.monkey <- get.next.monkey(worry.level, monkey)
      
      starting.items[[next.monkey]] <- c(starting.items[[next.monkey]], worry.level)
      
    }
    
    starting.items[[monkey]] <- c()
  }
}

cat("The product of the items touched by the two most active monkeys is ",
    prod(touched.items[order(touched, decreasing = T)][1:2, touched]),
    ".\n",
    sep = "")


## PART 2

max.rounds <- 10000
parse.input.data()

touched.items <- data.table(monkey = monkeys,
                            touched = 0)
setkey(touched.items, "monkey")

# PARSE DATA

for (round in 1:max.rounds) {
  
  for (turn in 0:(length(monkeys)-1)) {
    
    monkey <- paste("Monkey", turn)
    
    for (item in starting.items[[monkey]]) {
      
      touched.items[monkey, touched := touched+1]
      
      worry.level <- get.worry.level(item, monkey)
      worry.level <- worry.level %% prod(tests)
      next.monkey <- get.next.monkey(worry.level, monkey)
      
      starting.items[[next.monkey]] <- c(starting.items[[next.monkey]], worry.level)
      
    }
    
    starting.items[[monkey]] <- c()
  }
}

cat("The product of the items touched by the two most active monkeys is ",
    prod(touched.items[order(touched, decreasing = T)][1:2, touched]),
    ".\n",
    sep = "")
