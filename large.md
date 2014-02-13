# How to deal with larger-than-memory data

## Not about big data

Don't big data yourself as big data when your "big data" is not big data big as the genuine big data in the real big data big big data organizations

e.g. Google, Facebook, Human Genome Project, Large
Hadron Collider...

or maybe healthcare.gov

## 3Vs

1. Volume
2. Variability
3. Velocity

## As always, preliminaries

1. Memory & 64 bit & space-time tradeoff
2. Object size
3. Overhead

## One little assumption: you are not using Windows

1. memory.size() / memory.limit() sucks
2. Disk-pointer-based solution: NA or Not good
3. I hate Windows

## R is memory intensive

All objects LIVE in RAM.

## Max memory

1. Max memory for 32 bit built: 3.5G (practically < 2G)
2. 64 bit: 128TB

## Swapping and garbage collection

Often die instead of swapping. When swap, the system is "unusable" / "wasted" / "hang".

## R-admin

[R Installation and Administration](http://cran.r-project.org/doc/manuals/R-admin.html#Choosing-between-32_002d-and-64_002dbit-builds) - 8

```
this (Swapping / gc) will become an issue with objects more than 10% of the size of the address space (around 300Mb) or when the total size of objects in use is around one third (around 1Gb).
```

## Space-time tradeoff

There ain't no such thing as a free lunch.

On the same machine, 64 bit is (negligibly to 20%) slower than 32 bit when you are working on a small dataset.

## Error message

```
Error: cannot allocate vector of size ?? Mb / Gb
```

## object.size()

```{r}
object.size(iris)
print(object.size(iris), units = "Kb")
```

## RAM upgraded, I still get the "cannot allocate" error

1. Memory fragmentation
2. Overhead

## One example of overhead: COPY

```{r}
iris2 <- iris
tracemem(iris2)
iris2$Sepal.length.larger.than.5 <- iris2$Sepal.length > 5
```

## What you can do about it

1. Approximation
2. Chunking + incremental
3. HD pointer
4. Other solutions: Hadooq, Apache Spark... Not go into detail

## Approximate answer #1

"Far better an approximate answer to the right question, which is
often vague, than an exact answer to the wrong question, which can
always be made precise"

John Tukey

## Central limit theorem #1

```{r}
x <- rnorm(100000, 3, 4)
mean(sample(x, 1000)) ### approximate 3, with only 1% of the data
```

Just one big caution: Make sure the chance of being selected is equal

## Random sampling out of R

O(N)

```{perl}
perl -ne 'print if (rand() < 0.01 )' yourbigass.csv > smallass.csv
```

O(N * log N) but you will get exactly 1000 lines

```{sql}
select * from yourbigasstable order by random() limit 1000;
```

O(N)

```{sql}
select * from yourbigasstable where random() < 0.01;
```

## Chunking

You have a large data

1. read n records, or a chunk
2. process them
3. lather, rinse, repeat

n = chunk size.

Too large = kill the machine, too small = waste the cost

## Chunking: using file()

file connection can provide the classic C style I/O experience.

## Chunking: using SQL

DBI is intrinsic chunkable.

```r
library(RSQLite)
joinedresults <- dbSendQuery(exampledb,
"SELECT sbp, dbp, sbp-dbp AS pulsep, snp1, snp3 FROM
phenotypes INNER JOIN genotypes USING(id) WHERE sex = 'MALE'")
fetch(joinedresults, 10)
```

## netCDF

Not go into detail but very useful.

## Space-time tradeoff

## Model

## Approximate answer : Stochastic alogo / online algo

Not go into detail

[My blog post](http://www.chainsawriot.com/archives/7905)

## More accurate approximate answer : incremental alogo

example: biglm

## You can write yourself incremental algo

e.g. k-means

design some data structure, n instances, m * v variables and K means

Assuming data order is constant.

1. membership matrix: n x 2

current member, previous member

2. centroid matrix: k x m

mean for v1, mean for v2, ... mean or vm

## k-means

1. randomly select k cases as initial centroids
2. Assignment: Move the current membership to previous membership. For
   each data point, calculate the euclidean distance between the data
   point and each centroids, assign current membership. Using chunking
3. Update the centroids again using chunking
4. Lather, Rinse, Repeat (until no membership change)

## tips: use multicore!

Assign different cores for each subset of data.

## Non-chunking: harddisk pointer

Example: bigmemory & biganalytics

Not a drop-in replacement for matrix / data.frame

You need to write algorithm yourself.

## Memory requirement

My Chunking k means - 76M - Virtually forever
data.frame - 916M - 2 m 40 s 
bigmemory - 316M - 1 m

