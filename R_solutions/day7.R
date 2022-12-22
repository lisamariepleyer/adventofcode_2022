library(data.table)

### DAY 7

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

input <- readLines(data)

## PART 1

get.file <- function(x, size = F) {
  x <- strsplit(x, split = " ")[[1]]
  if (size == F) {
    return(x[2])
  } else {
    return(as.integer(x[1]))
  }
}

get.dir <- function(x) {
  x <- strsplit(x, split = " ")[[1]]
  if (x[1] == "dir") return (x[2])
  if (x[1] == "$") return (x[3])
  else break
}

paths <- c("/root/")

current.path <- paths
current.size <- 0

tmp.dir.size <- data.table(dir = c(),
                           size = c())

for (i in 2:length(input)) {
  
  # skip if ls
  if (length(grep("\\$ ls", input[i])) > 0) next
  
  # add to paths if directory
  if (length(grep("^dir ", input[i])) > 0) {
    paths <- c(paths, 
               paste0(current.path, get.dir(input[i]), "/"))
  }
  
  # add size to directory if file
  if (length(grep("[0-9] [a-z].[a-z]", input[i])) > 0) {
    current.size <- current.size + get.file(input[i], size = T)
  }
  
  # switch dir if cd dir
  if (length(grep("\\$ cd [[:alpha:]]", input[i])) > 0) {
    if (current.size > 0) {
      tmp.dir.size <- rbindlist(list(tmp.dir.size, 
                                     data.table(dir = current.path,
                                                size = current.size)))
    }
    
    current.path <- paste0(current.path, get.dir(input[i]), "/")
    current.size <- 0
  }
  
  # switch dir if cd ..
  if (input[i] == "$ cd ..") {
    if (current.size > 0) {
      tmp.dir.size <- rbindlist(list(tmp.dir.size, 
                                     data.table(dir = current.path,
                                                size = current.size)))
    }
    
    current.path <- paste0(dirname(current.path), "/")
    current.size <- 0
  }
  
  # save directory size of EOF
  if (i == length(input)) {
    tmp.dir.size <- rbindlist(list(tmp.dir.size, 
                                   data.table(dir = current.path,
                                              size = current.size)))
  }
  
}

setkey(tmp.dir.size, "dir")

path.sizes <- sapply(paths, function(x) {
  tmp.dir.size[grep(x, paths, value = T)][!is.na(size), sum(size)]
})

cat("The sum of the total sizes of the directories with total sizes of at most 100,000 is ",
    sum(path.sizes[which(path.sizes <= 100000)]),
    ".\n",
    sep = "")


## PART 2

to.be.deleted <- 30000000 - (70000000 - path.sizes["/root/"])

cat("The smallest directory that would free up enough space has a total size of ",
    sort(path.sizes[which(path.sizes > to.be.deleted)])[1],
    ".\n",
    sep = "")
