---
title: 'RSI(2) with Position Sizing'
date: 2009-05-01T20:58:00.011-05:00
draft: false
aliases: [ "/2009/05/rsi2-with-position-sizing.html" ]
tags : [Examples, Code]
---

Though it's more than two weeks later, here's the second post in the series that will demonstrate how to build, test, and implement a trading strategy with [R](http://www.r-project.org/). You can find the first post [here](http://blog.fosstrading.com/2009/04/testing-rsi2-with-r.html).  
  
The [first post](http://blog.fosstrading.com/2009/04/testing-rsi2-with-r.html) replicated this [simple RSI(2) strategy](http://marketsci.wordpress.com/2008/12/09/trading-with-rsi2/) from the [MarketSci Blog](http://marketsci.wordpress.com/). This second post will demonstrate how to replicate [this strategy](http://marketsci.wordpress.com/2008/12/14/trading-strategy-scaling-inout-of-rsi2/) that scales in/out of RSI(2).  
  
A couple notes before moving to the code:  

1.  The rsi2pos() function isn't _necessary_, but it provides an example of how to define a function. Plus, it enables us to test several ideas with much greater speed and flexibility.
  
3.  The ifelse() function works on entire vectors at once, avoiding costly loops (loops are costly in R because it's an interpreted language). Since we can potentially modify the entire 'size' vector, we must be mindful of the order of the tests.

  
On to the code!  

> \# Attach the quantmod and TTR packages.  
> \# You can install packages via:  
> \# install.packages(c("quantmod","TTR"))  
> library(quantmod)  
> library(TTR)  
>   
> \# Pull S&P500 index data from Yahoo! Finance  
> getSymbols("^GSPC", from="2000-01-01", to="2008-12-07")  
>   
> \# Calculate the RSI indicator  
> rsi <- RSI(Cl(GSPC),2)  
>   
> \# Calculate Close-to-Close returns  
> \# (this assumes we open/close our positions  
> \# at each day's close)  
> ret <- ROC(Cl(GSPC))  
> ret\[1\] <- 0  
>   
> \# Define our position-sizing function  
> rsi2pos <- function(ind, indIncr=5, posIncr=0.25) {  
> \# Inputs:  
> \# ind : indicator vector  
> \# indIncr : indicator value increments/breakpoints  
> \# posIncr : position value increments/breakpoints  
>   
> \# Initialize result vector  
> size <- rep(0,NROW(ind))  
>   
> \# Long  
> size <- ifelse(ind < 4\*indIncr, (1-posIncr\*3), size)  
> size <- ifelse(ind < 3\*indIncr, (1-posIncr\*2), size)  
> size <- ifelse(ind < 2\*indIncr, (1-posIncr\*1), size)  
> size <- ifelse(ind < 1\*indIncr, (1-posIncr\*0), size)  
>   
> \# Short  
> size <- ifelse(ind > 100-4\*indIncr, 3\*posIncr-1, size)  
> size <- ifelse(ind > 100-3\*indIncr, 2\*posIncr-1, size)  
> size <- ifelse(ind > 100-2\*indIncr, 1\*posIncr-1, size)  
> size <- ifelse(ind > 100-1\*indIncr, 0\*posIncr-1, size)  
>   
> \# Today's position ('size') is based on today's  
> \# indicator, but we need to apply today's position  
> \# to the Close-to-Close return at tomorrow's close.  
> size <- lag(size)  
>   
> \# Replace missing signals with no position  
> \# (generally just at beginning of series)  
> size\[is.na(size)\] <- 0  
>   
> \# Return results  
> return(size)  
> }  
>   
> \# Calculate signals using the 'rsi2pos()' function  
> sig <- rsi2pos(rsi, 5, 0.25)  
>   
> \# Break out the long (up) and short (dn) signals  
> sigup <- ifelse(sig > 0, sig, 0)  
> sigdn <- ifelse(sig < 0, sig, 0)  
>   
> \# Calculate equity curves  
> eq\_up <- exp(cumsum(ret\*sigup))  
> eq\_dn <- exp(cumsum(ret\*sigdn))  
> eq\_all <- exp(cumsum(ret\*sig))  
>   
> \# Replicate Michael's nice chart (again)  
> png(filename="20090430\_rsi2\_replication.png")  
> plot.zoo( cbind(eq\_up, eq\_dn), plot.type="single",  
> ylab=c("Long","Short"), col=c("green","red"),  
> main="RSI(2) Strategy, with Position Scaling:\\n 2000-01-03 through 2008-12-07" )  
> dev.off()

  
[![](/post/images/20090501_rsi2_replication.png)](/post/images/20090501_rsi2_replication.png)  

> \# Calculate signals using the 'rsi2pos()' function  
> \# with new values  
> sig <- rsi2pos(rsi, 10, 0.3)  
>   
> \# Break out the long (up) and short (dn) signals  
> sigup <- ifelse(sig > 0, sig, 0)  
> sigdn <- ifelse(sig < 0, sig, 0)  
>   
> \# Calculate equity curves  
> eq\_up <- exp(cumsum(ret\*sigup))  
> eq\_dn <- exp(cumsum(ret\*sigdn))  
> eq\_all <- exp(cumsum(ret\*sig))  
>   
> \# Re-plot equity curves using updated values  
> png(filename="20090501\_rsi2\_updated.png")  
> plot.zoo( cbind(eq\_up, eq\_dn), plot.type="single",  
> ylab=c("Long","Short"), col=c("green","red"),  
> main="Updated RSI(2) Strategy, with Position Scaling:\\n 2000-01-03 through 2008-12-07" )  
> dev.off()

  
[![](/post/images/20090501_rsi2_updated.png)](/post/images/20090501_rsi2_updated.png)  
Visual inspection of the charts seems to indicate the updated RSI(2) strategy has slightly higher returns, but more volatility and larger drawdowns.  
  
The [PerformanceAnalytics](http://cran.r-project.org/web/packages/PerformanceAnalytics/index.html) package can evaluate the volatility, drawdowns, and related metrics for investing and trading strategies.  We'll use it in the next post to [evaluate RSI(2)](http://blog.fosstrading.com/2009/06/rsi2-evaluation.html).