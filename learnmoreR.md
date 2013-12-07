# Learn more R

by CH Chan a.k.a. Chainsaw Riot


I'd like to start a new project with an uncreative name called "learn more R".
I want to try this project is because I still have that uneasiness of abusing some R functions to do what they are not supposed to do.

Then, I saw [this](http://datatable.r-forge.r-project.org/JimHoltman.pdf).
The last slide of Jim Holtman's talk listed "subset of R functions to start with". I have a look at these functions and I know that I am actually not that fluent in those "starter" R functions.

For some strangely named functions such as lapply, substr or mtext, I kind of know what they are doing, probably because of their strange names. However, for functions with regular names such as all, any, approx, assign, cut, exist, get, etc... I don't even know their existence, not to mention the functions of those functions.

I want to use that slide as the plan to discover and study those unknown functions.

## #1: all, any

7 - Dec - 2013

For the evaluation of multiple logical values, e.g. logical vector.

* all: Only return true when all logical values in the collection are true
* any: Return true when any logical values in the collection is true 


```r
### all
all(TRUE, TRUE, TRUE, 1 > 2)
```

```
## [1] FALSE
```

```r
all(c(TRUE, TRUE, TRUE, 1 < 2))
```

```
## [1] TRUE
```

```r
evens <- c(2, 4, 6, 8, 10)
all((evens%%2) == 0)
```

```
## [1] TRUE
```

```r
#### any
any(FALSE, FALSE, FALSE)
```

```
## [1] FALSE
```

```r
any(FALSE, 1 < 2, FALSE)
```

```
## [1] TRUE
```

```r
any(c(TRUE, FALSE, FALSE, FALSE))
```

```
## [1] TRUE
```

```r
evens <- c(2, 4, 6, 9, 10)  ### really?
any((evens%%2) != 0)  ### check for non even
```

```
## [1] TRUE
```

```r
### application: check for the preconditions
pigChar <- function(x) {
    stopifnot(all(nchar(x) == 1))
    return(paste(sapply(x, function(x) paste0(x, "p")), collapse = "ig"))
}
pigChar(c("a", "b", "c", "x", "y", "4"))
```

```
## [1] "apigbpigcpigxpigypig4p"
```

```r
pigChar(c("Pig", "sucks", "a"))
```

```
## Error: all(nchar(x) == 1) is not TRUE
```

