library(data.table)

### DAY 1

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

elf.separators <-c(0, which(data==""), length(data)+1)

calories.per.elf <- data.table(
  elfID=paste("elf", 1:(length(elf.separators)-1), sep="_"),
  calories=unlist(lapply(1:(length(elf.separators)-1), 
                         function(i) {
                           return(sum(as.numeric(data[(elf.separators[i]+1):(elf.separators[i+1]-1)])))})))

cat("The elf that is carrying the most calories is carrying", 
    max(calories.per.elf$calories),
    "calories.\n",
    sep = " ")


## PART 2

cat("The top three elves are carrying a total of", 
    sum(calories.per.elf[order(calories, decreasing = T)][1:3, calories]),
    "calories.\n",
    sep = " ")
