---
title: 'Margin Constraints with LSPM'
date: 2010-08-01T23:31:00.000-05:00
draft: false
aliases: [ "/2010/08/margin-constraints-with-lspm.html" ]
categories: [ Articles ]
tags : [Examples, LSPM]
---

When optimizing leverage space portfolios, I frequently run into the issue of one or more f$ (\[Max Loss\]/f) being less than the margin of its respective instrument.  For example, assume the required margin for an instrument is $500, f$ is $100, and $100,000 in equity.  The optimal amount to trade is 1,000 shares ($100,000/$100).  However, that would require $500,000 in equity, while you only have $100,000.  What do you do?  
  
Page 341 of [The Handbook of Portfolio Mathematics](http://www.amazon.com/gp/product/0471757683?ie=UTF8&tag=fosstrading-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0471757683) outlines how to determine how many units to trade, given margin constraints.  The methodology therein suggests finding optimal f values first, then calculating the portfolio that satisfies the margin constraints but keeps the ratio of each market system to one another the same.  
  
For those without the book, the calculation is:  
L = max(f$) / sum( ( max(f$) / f$\[i\] ) \* margin\[i\] )  
  
Where:  
L = percentage of "active equity" to use when dividing by each f$  
margin = initial margin for each market system  
  
The `maxUnits()` function included in this post uses the formula above to return the maximum number of tradeable units.  In this example, we assume our margin is equal to our maximum loss (as is the case with equities).  The code below illustrates how to use the `maxUnits()` function after optimization.  
  
```r
# Load the LSPM package
library(LSPM)

maxUnits <- function(lsp, margin, equity) {

  # Make sure margin and f are same length
  NRf <- NROW(lsp$f)
  if(NROW(margin)!=NRf)
    stop(paste("'margin' must have length =",NRf))

  # Calculate maximum equity percentage
  fDollar <- -lsp$maxLoss / lsp$f
  maxfDollar <- max( fDollar[is.finite(fDollar)] )

  den <- maxfDollar / fDollar * margin
  den[!is.finite(den)]  <- 0

  eqPct <- min(1, maxfDollar/sum(den))

  max.units <- eqPct * equity / fDollar
  return(max.units)
}

data(port)               # Multiple strategy data
initEq <- 100000         # Initial equity
margin <- -port$maxLoss  # Margin amounts

opt <- optimalf(port)    # Optimize portfolio
port$f <- opt$f          # Assign optimal f values to lsp object

# Units to trade
fUnits <- initEq/(-port$maxLoss/port$f)  # unconstrained
mUnits <- maxUnits(port, margin, initEq) # margin-constrained

# Equity needed to trade at f values
sum(fUnits*margin)  # unconstrained
sum(mUnits*margin)  # margin-constrained

# Implied f values based on maximum units
port$f <- mUnits*-port$maxLoss/initEq
GHPR(port)  # 1.209931
```
