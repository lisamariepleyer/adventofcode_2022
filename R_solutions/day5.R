library(data.table)

### DAY 5

args <- commandArgs(trailingOnly = T)
data <- args[which(args == "-in") + 1]

data <- readLines(data)

## PART 1

# PARSE INPUT DATA TO DATA.TABLE AND MATRIX FOR EASY ACCESS

moves <- data[(which(data == "")+1):length(data)]
stacks <- data[1:(which(data == "")-2)]

stacks <- do.call(rbind, 
                  lapply(1:length(stacks), 
                         function (i) {
                           
  tmp <- strsplit(stacks[i], split = " ")[[1]]
  
  crates <- c()
  j <- 1
  while(j <= length(tmp)) {
    if (tmp[j] == "") {
      crates <- c(crates, "[ ]")
      j = j + 4
    } else {
      crates <- c(crates, tmp[j])
      j = j + 1
    }
  }
  
  return (crates)
}))

# make sure there's enough space to add crates
stacks <- rbind(matrix("[ ]", 
                       nrow = matrix(((nrow(stacks)*ncol(stacks)) - length(which(stacks == "[ ]")))-nrow(stacks)),
                       ncol = ncol(stacks)),
                stacks)

starting.stacks <- copy(stacks)

moves <- as.data.table(do.call(rbind, 
                               lapply(moves, 
                                      function(m) {
  return(as.integer(strsplit(m, split = " ")[[1]][c(2, 4, 6)]))
})))
names(moves) <- c("quantity", "from", "to")

rm(data)

# ESTABLISH SIMULATION RULES

row.top.crate <-  function(col, add = 0) {
  row <- which(stacks[,col] != "[ ]")[1]
  row <- row + add
  
  if (is.na(row)) {
    row <- nrow(stacks)
  }
  
  return(row)
}

move.crate <- function(old.position, new.position) {
  moving.crate <- stacks[old.position[1], old.position[2]]
  
  stacks[new.position[1], new.position[2]] <- moving.crate
  stacks[old.position[1], old.position[2]] <- "[ ]"
  
  return (stacks)
}

# RUN SIMULATION

for (move in 1:nrow(moves)) {
  from.col <- moves[move, from]
  to.col <- moves[move, to]
  quantity <- moves[move, quantity]
  
  from.row <- row.top.crate(from.col)
  to.row <- row.top.crate(to.col, add = -1)
  
  for (quan in 1:quantity) {
    stacks <- move.crate(c(from.row, from.col), c(to.row, to.col))
    
    from.row <- from.row + 1
    to.row <- to.row - 1
  }
}

cat("After the rearrangement the crates on top of each stack are ",
    paste(sapply(1:ncol(stacks), 
                 function(col) {
                   strsplit(stacks[row.top.crate(col), col], 
                            split = "")[[1]][2]
                 }), 
          collapse = ""),
    ".\n",
    sep = "")


## PART 2

stacks <- starting.stacks

# RUN SIMULATION

for (move in 1:nrow(moves)) {
  from.col <- moves[move, from]
  to.col <- moves[move, to]
  quantity <- moves[move, quantity]
  
  from.row <- row.top.crate(from.col)+quantity-1
  to.row <- row.top.crate(to.col, add = -1)
  
  for (quan in 1:quantity) {
    stacks <- move.crate(c(from.row, from.col), c(to.row, to.col))
    
    from.row <- from.row - 1
    to.row <- to.row - 1
  }
}

cat("After the rearrangement the crates on top of each stack are ",
    paste(sapply(1:ncol(stacks), 
                 function(col) {
                   strsplit(stacks[row.top.crate(col), col], 
                            split = "")[[1]][2]
                 }), 
          collapse = ""),
    ".\n",
    sep = "")

