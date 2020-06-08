---
title: 'Comment on Overnight SPY Anomaly'
date: 2015-11-16T11:25:00.000-06:00
draft: false
aliases: [ "/2015/11/overnight-spy-anomaly.html" ]
tags : [R]
---

This post is in response to Michael Harris' [Price Action Lab post](http://www.priceactionlab.com/Blog/2015/11/overnight-trading-anomaly-backtesting-r/), where he uses some simple R code to evaluate the asymmetry of returns from the day's close to the following day's open.  I'd like to respond to his 3 notes, which I've included below.  

> 1.  The R backtest assumes fractional shares. This means that equity is fully invested at each new position. This is important because it affects drawdown calculations.
> 2.  When calculating the Sharpe ratio, the “geometric = FALSE” option must be used otherwise the result may not be correct. It took some time to figure that out.
> 3.  The profit factor result in R does not reconcile with results from other platforms or even from excel. PF in R is shown as 1.23 but the correct value is 1.17. Actually, the profit factor is calculated on a per share basis in R, although returns are geometric.

I completely agree with the first point.  I'm not sure Mike considers the output of  `SharpeRatio.annualized` with `geometric=TRUE` to be suspect (he doesn't elaborate).  The `overnightRets` are calculated as arithmetic returns, so it's proper to aggregate them using geometric chaining (i.e. multiplication).  
  
I also agree with the third point, because the R code used to calculate profit factor is wrong.  My main impetus to write this post was to provide a corrected profit factor calculation.  The calculation (with slightly modified syntax) in Mike's post is:  
  
```r
require(quantmod)
getSymbols('SPY', from = '1900-01-01')
SPY <- adjustOHLC(SPY, use.Adjusted=TRUE)
overnightRets <- na.omit(Op(SPY)/lag(Cl(SPY)) - 1)
posRet <- overnightRets > 0
profitFactor <- -sum(overnightRets[posRet])/sum(overnightRets[!posRet])
```

Note that profit factor in the code above is calculated by summing positive and negative _returns_, when it should be calculated using positive and negative _P&L_.  In order to do that, we need to calculate the equity curve and then take its first difference to get P&L.  The corrected calculation is below, and it provides the correct result Mike expected.

```r
grossEquity <- cumprod(overnightRets+1)
grossPnL <- diff(grossEquity)
grossProfit <- sum(grossPnL[grossPnL > 0])
grossLoss <- sum(grossPnL[grossPnL < 0])
profitFactor <- grossProfit / abs(grossLoss)
```

I'd also like to respond to Mike's comment:  

> Since in the past I have identified serious flaws in commercially available backtesting platforms, I would not be surprised if some of the R libraries have some flaws.

I'm certain all of the backtesting R packages have flaws/bugs.  All software has bugs because all software is written by fallible humans.  One nice thing about (most) R packages is that they're open source, which means anyone/everyone can check the code for bugs, and fix any bugs that are found.  With closed-source software, commercial or not, you depend on the vendor to deliver a patched version at their discretion and in their timing.

Now, I'm not making an argument that open source software is inherently better. I simply wanted to point out this one difference.  As much as I love open source software, there are times where commercial vendor-supported software presents a more appealing set of tradeoffs than using open source software.  Each situation is different.
