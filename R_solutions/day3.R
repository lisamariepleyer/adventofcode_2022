library(data.table)

### DAY 3

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

priority <- data.table(let=c(letters, LETTERS),
                       val=c(1:52))

wrong.items <- data.table(let = sapply(data, function(s) {
  compartment1 <- strsplit(substr(s, 1, nchar(s)/2), split = "")[[1]]
  compartment2 <- strsplit(substr(s, (nchar(s)/2)+1, nchar(s)), split = "")[[1]]
  return(intersect(compartment1, compartment2))
}))

cat("The sum of the misplaced item types of all rucksacks is ",
    merge(priority, wrong.items)[, sum(val)],
    ".\n",
    sep = "")


## PART 2

group.size <- 3

common.items <- data.table(let = sapply(seq(from = 1, to = length(data), by = group.size), function(i) {
  Reduce(intersect, 
         lapply(data[i:(i+group.size-1)], function(s) { strsplit(s, split = "")[[1]] }))
}))

cat("The sum of the item types shared between groups is ",
    merge(priority, common.items)[, sum(val)],
    ".\n",
    sep = "")
