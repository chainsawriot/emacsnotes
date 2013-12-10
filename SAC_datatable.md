# Notes on SAC using data.table

[Link to the original SAC presentation](https://docs.google.com/presentation/d/1iuXjJvX0XkNzR-zAJaljOIREPcVnVm6FvCwjH8bIMYg/edit?usp=sharing)

# Iris data set
## Slide 27

Calculate the mean and SD of Sepal Length for each species


```r
library(data.table)
```

```
## Warning: package 'data.table' was built under R version 3.0.1
```

```r
iris.dt <- data.table(iris, key = "Species")  ### create a dt with Species as key
iris.dt[, list(mean = mean(Sepal.Length), sd = sd(Sepal.Length)), by = Species]
```

```
##       Species  mean     sd
## 1:     setosa 5.006 0.3525
## 2: versicolor 5.936 0.5162
## 3:  virginica 6.588 0.6359
```


## Slide 30
Calculate the Species-specific z score


```r
iris.dt[, `:=`(z, (Sepal.Length - mean(Sepal.Length))/sd(Sepal.Length)), by = Species]
```

```
##      Sepal.Length Sepal.Width Petal.Length Petal.Width   Species        z
##   1:          5.1         3.5          1.4         0.2    setosa  0.26667
##   2:          4.9         3.0          1.4         0.2    setosa -0.30072
##   3:          4.7         3.2          1.3         0.2    setosa -0.86811
##   4:          4.6         3.1          1.5         0.2    setosa -1.15181
##   5:          5.0         3.6          1.4         0.2    setosa -0.01702
##  ---                                                                     
## 146:          6.7         3.0          5.2         2.3 virginica  0.17613
## 147:          6.3         2.5          5.0         1.9 virginica -0.45292
## 148:          6.5         3.0          5.2         2.0 virginica -0.13839
## 149:          6.2         3.4          5.4         2.3 virginica -0.61018
## 150:          5.9         3.0          5.1         1.8 virginica -1.08197
```


# Baby name dataset
## Slide 34-35

Reading csv into data table


```r
babyname <- fread("~/Dropbox/SACdemo/bnames.csv")
setkeyv(babyname, cols = c("year", "sex"))
```


Get the most popular name by year and sex


```r
babyname[, name[which.max(percent)], by = list(year, sex)]
```

```
##      year  sex    V1
##   1: 1880  boy  John
##   2: 1880 girl  Mary
##   3: 1881  boy  John
##   4: 1881 girl  Mary
##   5: 1882  boy  John
##  ---                
## 254: 2006 girl Emily
## 255: 2007  boy Jacob
## 256: 2007 girl Emily
## 257: 2008  boy Jacob
## 258: 2008 girl  Emma
```


## Slide 39

Get the total percentage of the first character of the baby names by year and gender


```r
letterFreq <- babyname[, list(sumPer = sum(percent)), by = list(year, sex, first = tolower(substr(name, 
    1, 1)))]
library(ggplot2)
ggplot(letterFreq, aes(x = year, y = sumPer, group = sex)) + geom_line(aes(color = sex)) + 
    facet_wrap(~first, nrow = 3)
```

![plot of chunk letterfreq](figure/letterfreq.png) 

