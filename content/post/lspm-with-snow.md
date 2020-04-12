---
title: 'LSPM with snow'
date: 2010-01-10T17:01:00.003-06:00
draft: false
aliases: [ "/2010/01/lspm-with-snow.html" ]
tags : [Examples, LSPM]
---

My [last post](http://blog.fosstrading.com/2010/01/lspm-examples.html) provided examples of how to use the [LSPM package](http://r-forge.r-project.org/projects/lspm). Those who experimented with the code have probably found that constrained optimizations with horizons > 6 have long run-times (when calc.max >= horizon).  
  
This post will illustrate how the [snow](http://cran.r-project.org/web/packages/snow/) package can increase the speed of the probDrawdown and probRuin functions on computers with multiple cores. This yields nearly linear improvements in run-times relative to the number of cores. (Improvements are nearly linear because there is overhead in setting up the cluster and communication between the nodes.)  
  
The first optimization takes 346 seconds on my 2.2Ghz Centrino, while the second optimization (with snow) takes 193 seconds... nearly a 45% improvement.  
  
\# Load the libraries  
library(LSPM)  
library(snow)  
  
\# Create a Leverage Space Portfolio object  
trades <- cbind(  
c(-150,-45.33,-45.33,rep(13,5),rep(79.67,3),136),  
c(253,-1000,rep(-64.43,3),253,253,448,rep(-64.43,3),253),  
c(533,220.14,220.14,-500,533,220.14,799,220.14,-325,220.14,533,220.14) )  
probs <- c(rep(0.076923077,2),0.153846154,rep(0.076923077,9))  
port <- lsp(trades,probs)  
  
\# Optimization using one CPU core  
system.time({  
res1 <- optimalf(port,probDrawdown,0.1,DD=0.2,horizon=5,control=list(NP=30,itermax=100))  
})  
  
\# Create snow socket cluster for both cores  
clust <- makeSOCKcluster(2)  
  
\# Optimization using both CPU cores  
system.time({  
res2 <- optimalf(port,probDrawdown,0.1,DD=0.2,horizon=5,snow=clust,control=list(NP=30,itermax=100))  
})  
  
\# Stop snow cluster  
stopCluster(clust)