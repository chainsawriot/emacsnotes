cus_col <- colorRampPalette(colors=c('white','black'))


train <- read.csv("train.csv")
m1 <- matrix(unlist(train[10000, 2:ncol(train)]), nrow=28, ncol=28)

image(m1[,28:1], col=cus_col(256))

displayDigit <- function(onerow, main="", col=cus_col(256)) {
    m1 <- matrix(unlist(onerow), nrow=28, ncol=28)
    image(m1[,28:1], col=cus_col(256), axes=FALSE, main=main)
}

rm(train)

### chunking k means

### select initial centroids by perl

system("perl -ne 'print if (rand() < 0.01 )' train.csv > train_subset.csv")

centroidsCandidate <- read.csv("train_subset.csv", header=FALSE)
centroids <- centroidsCandidate[sample(nrow(centroidsCandidate), 10),2:ncol(centroidsCandidate)]
row.names(centroids) <- seq(1, 10)

remove(centroidsCandidate)

system("wc -l train.csv") # we know that we have 42K data

### abuse the index of R's dataframe

#membership <- data.frame(prev=rep(NA, 42000), curr=rep(NA, 42000)) ### you can also use shard

## shard style solution
## V. slow, but can further reduce the memory requirement


### each RDS containing a vector of two elements: curr and prev

system("mkdir membership")

for (i in 1:42000) {
    saveRDS(c(0,0), paste0("./membership/", i, ".RDS"))
}

#test <- readRDS("./membership/3000.RDS")

#train <- file("train.csv", "r")
#chunk <- readLines(train, n = 1) ### skip the first line
#chunk <- readLines(train, n = 1)
#datapoint <- read.table(text=chunk, header=FALSE, sep=",", quote="\"")[,2:785]

#which.min(sapply(1:10, function(x, y) { dist(rbind(centroids[x,], y)) }, y=datapoint))


#image(matrix(unlist(centroids[1,]), nrow=28, ncol=28)[,28:1], col=cus_col(256))
#image(matrix(unlist(datapoint), nrow=28, ncol=28)[,28:1], col=cus_col(256))

### determine membership

membership <- function(id,datapoint,centroids) {
    prevmembership <- readRDS(paste0("./membership/", id, ".RDS"))
    #print(prevmembership)
    thismembership <- which.min(sapply(1:10, function(x, y) { dist(rbind(centroids[x,], y)) }, y=datapoint))
    print(paste0("Data: ", id, " previous: ", prevmembership[1], " new: ", thismembership))
    saveRDS(c(thismembership, prevmembership[1]), paste0("./membership/", id, ".RDS"))
}

#membership(1, datapoint, centroids)

#test <- readRDS("./membership/1.RDS")

assignmentPhase <- function(centroids) {
    train <- file("train.csv", "r")
    chunk <- readLines(train, n = 1) ### skip the first line
    for (i in 1:42000) {
        chunk <- readLines(train, n = 1)
        datapoint <- read.table(text=chunk, header=FALSE, sep=",", quote="\"")[,2:785]
        membership(i, datapoint, centroids)
    }
    close(train)
}

countMember <- function() {
    nummember <- rep(0, 10)
    homoIndex <- 0
    for (i in 1:42000) {
        member <- readRDS(paste0("./membership/", i, ".RDS"))
        nummember[member[1]] <- nummember[member[1]] + 1
        if (member[1] == member[2]) {
            homeIndex <- homeIndex + 1
        }
    }
    return(list(nummember, homoIndex))
}

centroidReassignment <- function(centroids) {
    newcentroids <- centroids
    newcentroids[newcentroids > 0] <- 0
    nummember <- rep(0, 10)
    homoIndex <- 0
    train <- file("train.csv", "r")
    chunk <- readLines(train, n = 1) ### skip the first line
    for (i in 1:42000) {
        chunk <- readLines(train, n = 1)
        datapoint <- read.table(text=chunk, header=FALSE, sep=",", quote="\"")[,2:785]
        member <- readRDS(paste0("./membership/", i, ".RDS"))
        newcentroids[member[1],] <- newcentroids[member[1],] + datapoint
        nummember[member[1]] <- nummember[member[1]] + 1
        if (member[1] == member[2]) {
            homoIndex <- homoIndex + 1
        }
        print(paste0("Data ", i, " processed. Current Homo Index: ", homoIndex))
    }
    close(train)
    return(list(newcentroids, homoIndex, nummember))
}

calNewCentroids <- function(res) {
    newcentroids <- res[[1]]
    for (i in 1:10)  {
        newcentroids[i, ] <- res[[1]][i,] / res[[3]][i]
    }
    return(newcentroids)
}



par(mfrow = c(2, 5))
for (i in 1:10) {
    displayDigit(centroids[i,], main=paste("Centroid:", i))
}

iteration <- function(centroids) {
    assignmentPhase(centroids)
    res <- centroidReassignment(centroids)
    return(calNewCentroids(res))
}

## change the
# centroids <- newcentriods

newcentroids <- iteration(centroids)
centroids <- newcentroids
newcentroids <- iteration(centroids)

par(mfrow = c(2, 5))
for (i in 1:10) {
    displayDigit(newcentroids[i,], main=paste("Centroid:", i))
}
