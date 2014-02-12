## Chunking demo

Journals <- file("Journals.csv", "r")
readLines(Journals, n=5)

readLines(Journals, n=50)
readLines(Journals, n=50)
readLines(Journals, n=50)

readLines(Journals, n=50)
length(readLines(Journals, n=50))


Journals <- file("Journals.csv", "r")
firstline <- readLines(Journals, n=1)
columnsname <- strsplit(firstline, ",")[[1]]
### remove '\"'

columnsname <- gsub('\\"', "", columnsname)


### look at the data using head in the shell

chunk <- readLines(Journals, n = 10)

read.table(text=chunk, header=FALSE, sep=",", quote="\"")

nextchunk <- readLines(Journals, n = 10)


read.table(text=nextchunk, header=FALSE, sep=",", quote="\"")

### using chunking to calculate the mean oclc (V10)

### non-// algo for large amount of data is usually iterative.

Journals <- file("Journals.csv", "r")
firstline <- readLines(Journals, n=1)

n <- 0
sumoclc <- 0

while(TRUE) {
    chunk <- readLines(Journals, n=2)
    if (length(chunk) == 0) {
        break
    }
    chunkDF <- read.table(text=chunk, header=FALSE, sep=",", quote="\"")
    sumoclc <- sumoclc + sum(chunkDF$V10, na.rm=TRUE)
    n <- n + length(chunkDF$V10[!is.na(chunkDF$V10)])
    print(paste0("Processed:", n))
}
close(Journals)

sumoclc / n

mean(read.csv("Journals.csv")[,10], na.rm=TRUE)

## Median / percentile calculation is doable but not as straight forward.
