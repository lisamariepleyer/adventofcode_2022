library(data.table)

### DAY 4

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- fread(data, header = F, col.names = c("elf.one", "elf.two"))

## PART 1

range.endpoints <- function(range) {
  return(as.integer(strsplit(range, split = "-")[[1]]))
}

is.contained.in.other <- sapply(1:nrow(data), function(i) {
  
  nums <- range.endpoints(as.vector(data[i, elf.one]))
  e1 <- nums[1]:nums[2]
  
  nums <- range.endpoints(as.vector(data[i, elf.two]))
  e2 <- nums[1]:nums[2]
  
  overlap.length <- length(intersect(e1, e2))
  
  if(length(e1) == overlap.length || length(e2) == overlap.length) {
    return(T)
  } else {
    return(F)
  }
})

cat("In ",
    sum(is.contained.in.other),
    " pairs one range is fully contained in the other.\n",
    sep = "")


## PART 2

is.overlapping.other <- sapply(1:nrow(data), function(i) {
  
  nums <- range.endpoints(as.vector(data[i, elf.one]))
  e1 <- nums[1]:nums[2]
  
  nums <- range.endpoints(as.vector(data[i, elf.two]))
  e2 <- nums[1]:nums[2]
  
  overlap.length <- length(intersect(e1, e2))
  
  if(overlap.length > 0) {
    return(T)
  } else {
    return(F)
  }
})

cat("In ",
    sum(is.overlapping.other),
    " pairs the two ranges overlap.\n",
    sep = "")
