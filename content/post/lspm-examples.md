---
title: 'LSPM Examples'
date: 2010-01-02T15:35:00.001-06:00
draft: false
aliases: [ "/2010/01/lspm-examples.html" ]
categories: [ Articles ]
tags : [Examples, LSPM]
---

I have received several requests for additional [LSPM](https://r-forge.r-project.org/projects/lspm) documentation over the past couple days and a couple months ago [I promised an introduction](http://blog.fosstrading.com/2009/09/update.html) to LSPM.  
  
In this long-overdue post, I will show how to optimize a Leverage Space Portfolio with the LSPM package.  Please use the comments to let me know what you would like to see next.  
  
Some copious notes before we get to the code:  
  
These examples are based on revision ~~26~~ 31 from r-forge and will not work under earlier revisions (and may not work with later revisions). LSPM is still in **very** alpha status.  Expect things to change, perhaps significantly.  
  
These examples were run using [DEoptim\_1.3-3](http://cran.r-project.org/src/contrib/Archive/DEoptim/DEoptim_1.3-3.tar.gz) (and LSPM revision 26 depends on that version) code from DEoptim\_1.3-3 that has been bundled inside LSPM.  We are working with the DEoptim authors to address issues with more recent versions of DEoptim.  LSPM will un-bundle and use the most recent version of DEoptim as soon as the issues are resolved.  
  
The first two examples are taken from [Vince, Ralph (2009). The Leverage Space Trading Model. New York: John Wiley & Sons, Inc.](http://www.amazon.com/gp/product/0470455950?ie=UTF8&tag=fotr09-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=0470455950)![](http://www.assoc-amazon.com/e/ir?t=fotr09-20&l=as2&o=1&a=0470455950) The results will not match the book because of differences between optimization via DEoptim and Ralph's genetic algorithm implementation.  Ralph believes his genetic algorithm is getting hung up on a local maximum, whereas DEoptim is closer to the global solution.  

```r
# Load the LSPM package  
library(LSPM)  
  
# Multiple strategy example (data found on pp. 84-87)  
trades <- cbind(  
 c(-150,-45.33,-45.33,rep(13,5),rep(79.67,3),136),  
 c(253,-1000,rep(-64.43,3),253,253,448,rep(-64.43,3),253),  
 c(533,220.14,220.14,-500,533,220.14,799,220.14,-325,220.14,533,220.14) )  
probs <- c(rep(0.076923077,2),0.153846154,rep(0.076923077,9))  

# Create a Leverage Space Portfolio object  
port <- lsp(trades,probs)  
  
# DEoptim parameters (see ?DEoptim)  
# NP=30        (10 * number of strategies)  
# itermax=100  (maximum number of iterations)  
DEctrl <- list(NP=30,itermax=100)  
  
# Unconstrainted Optimal f (results on p. 87)  
res <- optimalf(port,control=DEctrl)  
  
# Drawdown-constrained Optimal f (results on p. 137)  
# Since horizon=12, this optimization will take about an hour  
res <- optimalf(port,probDrawdown,0.1,DD=0.2,horizon=12,calc.max=4,control=DEctrl)  
  
# Ruin-constrained Optimal f  
res <- optimalf(port,probRuin,0.1,DD=0.2,horizon=4,control=DEctrl)  
  
# Drawdown-constrained Optimal f  
res <- optimalf(port,probDrawdown,0.1,DD=0.2,horizon=4,control=DEctrl)
```
