---
title: 'LSPM Joint Probability Tables'
date: 2010-05-18T22:30:00.004-05:00
draft: false
aliases: [ "/2010/05/lspm-joint-probability-tables.html" ]
categories: [ Articles ]
tags : [Examples, LSPM]
---

I've received several requests for methods to create joint probability tables for use in LSPM's portfolio optimization functions.  Rather than continue to email this example to individuals who ask, I post it here in hopes they find it via a Google search. ;-)  
  
I'm certain there are more robust ways to estimate this table, but the code below is a start...  

```r
# `x` is a matrix of market system returns
# `n` is the number of bins to create for each system
# `FUN` is the function to use to calculate the value for each bin
# `...` are args to be passed to `FUN`

jointProbTable <- function(x, n=3, FUN=median, ...) {

  # Load LSPM
  if(!require(LSPM,quietly=TRUE)) stop(warnings())

  # Function to bin data
  quantize <- function(x, n, FUN=median, ...) {
    if(is.character(FUN)) FUN <- get(FUN)
    bins <- cut(x, n, labels=FALSE)
    res <- sapply(1:NROW(x), function(i) FUN(x[bins==bins[i]], ...))
  }

  # Allow for different values of 'n' for each system in 'x'
  if(NROW(n)==1) {
    n <- rep(n,NCOL(x))
  } else
  if(NROW(n)!=NCOL(x)) stop("invalid 'n'")

  # Bin data in 'x'
  qd <- sapply(1:NCOL(x), function(i) quantize(x[,i],n=n[i],FUN=FUN,...))

  # Aggregate probabilities
  probs <- rep(1/NROW(x),NROW(x))
  res <- aggregate(probs, by=lapply(1:NCOL(qd), function(i) qd[,i]), sum)

  # Clean up output, return lsp object
  colnames(res) <- colnames(x)
  res <- lsp(res[,1:NCOL(x)],res[,NCOL(res)])

  return(res)
}

# Example
N <- 30
x <- rnorm(N)/100; y <- rnorm(N)/100; z <- rnorm(N)/100
zz <- cbind(x,y,z)

jpt <- jointProbTable(zz,n=c(4,3,3))
jpt
##                     x           y            z
## f         0.100000000  0.10000000  0.100000000
## Max Loss -0.009192644 -0.03090575 -0.006942066
##            probs            x            y            z
##  [1,] 0.06666667 -0.002152201 -0.030905750 -0.006942066
##  [2,] 0.06666667 -0.002152201 -0.006480683 -0.006942066
##  [3,] 0.03333333  0.024304901 -0.006480683 -0.006942066
##  [4,] 0.03333333 -0.009192644  0.001963339 -0.006942066
##  [5,] 0.06666667  0.008308007  0.001963339 -0.006942066
##  [6,] 0.03333333  0.024304901  0.001963339 -0.006942066
##  [7,] 0.03333333 -0.009192644 -0.006480683  0.001678969
##  [8,] 0.03333333  0.008308007 -0.006480683  0.001678969
##  [9,] 0.20000000 -0.009192644  0.001963339  0.001678969
## [10,] 0.06666667 -0.002152201  0.001963339  0.001678969
## [11,] 0.13333333  0.008308007  0.001963339  0.001678969
## [12,] 0.03333333  0.008308007 -0.006480683  0.013314122
## [13,] 0.03333333 -0.009192644  0.001963339  0.013314122
## [14,] 0.10000000 -0.002152201  0.001963339  0.013314122
## [15,] 0.06666667  0.008308007  0.001963339  0.013314122
```
