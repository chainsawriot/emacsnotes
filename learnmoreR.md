# Learn more R

by CH Chan a.k.a. Chainsaw Riot


I'd like to start a new project with an uncreative name called "learn more R".
I want to try this project is because I still have that uneasiness of abusing some R functions to do what they are not supposed to do.

Then, I saw [this](http://datatable.r-forge.r-project.org/JimHoltman.pdf).
The last slide of Jim Holtman's talk listed "subset of R functions to start with". I have a look at these functions and I know that I am not well versed in those "beginner" R functions.

For some strangely named functions such as lapply, substr or mtext, I kind of know what they are doing, probably because of their strange names. However, for functions with regular names such as all, any, approx, assign, cut, exist, get, etc... I don't even know their existence, not to mention the functionalities of those functions.

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


## #2: assign, get / mget, exists

7 - Dec - 2013

_assign_ is for assignment. The first argument *x* is the character string. The second argument *value* is the value to be assigned to *x*. A function of generating variables using side effect.


```r
assign("pig", "sucks")  ## exactly the same as: pig <- 'sucks'
pig
```

```
## [1] "sucks"
```

```r
assign("pig", "not sucks")
pig
```

```
## [1] "not sucks"
```

```r
for (x in 1:6) {
    assign(paste0("pig", x), 1:x)
}
pig5
```

```
## [1] 1 2 3 4 5
```


NB: Cannot assign element of vectors, names, attributes etc.

_get_ is to get the value of an object by name in character string. 


```r
assign("pig", "is not good")
pig
```

```
## [1] "is not good"
```

```r
get("pig") == pig
```

```
## [1] TRUE
```


_mget_ is the vectorized version of _get_.


```r
assign("pig1", "good")
assign("pig2", "bad")
assign("pig3", "so-so")
mget(c("pig1", "pig2", "pig3"))
```

```
## $pig1
## [1] "good"
## 
## $pig2
## [1] "bad"
## 
## $pig3
## [1] "so-so"
```


_exists_ is a predicate to check for existence of object by name in character string.


```r
assign("cat1", "goes meow")
assign("cat2", "what did the fox say?")
exists("cat1")
```

```
## [1] TRUE
```

```r
exists("dog1")
```

```
## [1] FALSE
```

