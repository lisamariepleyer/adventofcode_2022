
### DAY 6

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

signal <- strsplit(data, split = "")[[1]]

find.marker <- function(marker.length) {
  
  first.marker <- 0
  
  i <- marker.length
  while (first.marker == 0) {
    
    if (length(unique(signal[(i-marker.length+1):i])) == marker.length) {
      first.marker <- i
    } else {
      i <- i + 1
    }
  }
  
  return(first.marker)
}

cat(find.marker(4),
    " characters need to be processed before the first start-of-packet marker.\n",
    sep = "")


## PART 2

cat(find.marker(14),
    " characters need to be processed before the first start-of-packet marker.\n",
    sep = "")
