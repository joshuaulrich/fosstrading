---
title: 'Maximum Probability of Profit'
date: 2010-04-09T10:04:00.001-05:00
draft: false
aliases: [ "/2010/04/maximum-probability-of-profit.html" ]
tags : [Examples, LSPM]
---

To continue with the [LSPM examples](http://blog.fosstrading.com/2010/01/lspm-examples.html), this post shows how to optimize a Leverage Space Portfolio for the maximum probability of profit. The data and example are again taken from [The Leverage Space Trading Model](http://www.amazon.com/gp/product/0470455950?ie=UTF8&tag=fosstrading-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0470455950) by [Ralph Vince](http://www.ralphvince.com/).  
  
These optimizations take a very long time. 100 iterations on a 10-core Amazon EC2 cluster took 21 hours. Again, the results will not necessarily match the book because of differences between [DEoptim](https://cran.r-project.org/package=DEoptim) and Ralph's genetic algorithm and because there are multiple possible paths one can take through leverage space that will achieve similar results.  
  
The results from the EC2 run were:  

iteration: 100 best member: 0.0275 0 0.0315 -0.928 -1 best value: -0.9999

The book results (on p. 173) were:  

iteration: 100 best member: 0.085 0.015 0.129 -0.76 -0.992 best value: -0.9999

  
Specifying an initial population can give DEoptim an initial set of parameters that are within the constraint. This guarantees a starting point but it can slow optimization if the f (and/or z) values are too low. Therefore, experiment with the initial population to find a set of f (and/or z) values that produce a result within, but not far from, the constraint.  

```r
# Load the LSPM and snow packages
library(LSPM)
library(snow)

# Multiple strategy example (data found on pp. 84-87, 169)
trades <- cbind(
  c(-150,-45.333,-45.333,13,13,13,13,13,79.667,79.667,79.667,136),
  c(253,-1000,-64.429,-64.429,-64.429,253,253,448,-64.429,-64.429,-64.429,253),
  c(533,220.143,220.143,-500,533,220.143,799,220.143,-325,220.143,533,220.143))

probs <- c(0.076923076923,0.076923076923,0.153846153846,0.076923076923,
  0.076923076923,0.076923076923,0.076923076923,0.076923076923,
  0.076923076923,0.076923076923,0.076923076923,0.076923076923)

# Create a Leverage Space Portfolio object
port <- lsp(trades,probs)

# Number of population members
np <- 30

# Initial population
initpop <- cbind(runif(np,0,0.01),runif(np,0,0.01),runif(np,0,0.01),
  runif(np,-1,-0.8),runif(np,-1,-0.8))

# DEoptim parameters (see ?deoptim)
DEctrl <- list(NP=np, itermax=11, refresh=1, digits=6, initial=initpop)

# Create a socket cluster with snow to use both cores
# on a dual-core processor
cl <- makeSOCKcluster(2)

# Drawdown-constrained maximum probability of profit (results on p. 173)
res <- maxProbProfit(port, 1e-6, 12, probDrawdown, 0.1,
  DD=0.2, calc.max=4, snow=cl, control=DEctrl)
```
