---
title: 'David Varadi''s RSI(2) alternative'
date: 2009-07-19T08:38:00.003-05:00
draft: false
aliases: [ "/2009/07/david-varadis-rsi2-alternative.html" ]
tags : [Code]
---

Here's a quick R implementation of [David Varadi's](http://cssanalytics.wordpress.com/) alternative to the RSI(2).  Michael Stokes over at the [MarketSci](http://marketsci.wordpress.com/) blog has three great posts exploring this indicator:  

1.  [Varadi's RSI(2) Alternative: The DV(2)](http://marketsci.wordpress.com/2009/07/15/varadi%e2%80%99s-rsi2-alternative-the-dv2/)
2.  [RSI(2) vs. DV(2)](http://marketsci.wordpress.com/2009/07/16/rsi2-vs-dv2/)
3.  [Last Couple of Notes on DV(2)](http://marketsci.wordpress.com/2009/07/17/last-couple-of-notes-on-dv2/)

Here's the R code:  

```r
DV <- function(HLC, n=2, bounded=FALSE) {  
  # "HLC" is an _xts_ object with "High", "Low", and "Close"  
  # columns, in that order.  
  
  # This is David Varadi's alternative to the RSI(2).  Calculations  
  # taken from the marketsci blog -- http://marketsci.wordpress.com  
  # Author of this implementation: Joshua Ulrich  
  
  # Calculate each day's high/low mean  
  hlMean <- rowMeans( HLC[,-3] )  
  
  # Calculate the running Mean of the Close divided by the  
  # high/low mean, then subtract 1.  
  res <- runMean( HLC[,3] / hlMean, n ) - 1  
  
  # If we want the bounded DV...  
  if(bounded) {  
    # Set the range to calculated the bounded DV  
    rng <- 252:NROW(res)  
  
    # Grab the index of the unbounded results, so we can convert  
    # the bounded results back to an xts object.  
    indx <- index(res)  
  
    # A simple percent rank function hack  
    pctRank <- function(x,i) match(x[i], sort(coredata(x[(i-251):i])))  
  
    # Apply the percent rank function to the coredata of our results  
    res <- sapply(rng, function(i) pctRank(res, i) / 252)  
  
    # Convert the bounded results to xts  
    res <- xts(c(rep(NA,251),res), indx)  
  }  
  
  # Return results  
  return(res)  
}
```
