library(data.table)

### DAY 1

## PART 1

data <- readLines("data.txt")
elf.separators <-c(0, which(data==""), length(data)+1)

calories.per.elf <- data.table(
  elfID=paste("elf", 1:(length(elf.separators)-1), sep="_"),
  calories=unlist(lapply(1:(length(elf.separators)-1), 
                         function(i) {
                           return(sum(as.numeric(data[(elf.separators[i]+1):(elf.separators[i+1]-1)])))})))

print(paste("The elf that is carrying the most calories is carrying", 
            max(calories.per.elf$calories),
            "calories."))

## PART 2

print(paste("The top three elves are carrying a total of", 
            sum(calories.per.elf[order(calories, decreasing = T)][1:3, calories]),
            "calories."))

