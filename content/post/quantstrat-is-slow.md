---
title: 'quantstrat is slow'
date: 2013-11-04T06:37:00.000-06:00
draft: false
aliases: [ "/2013/11/quantstrat-is-slow.html" ]
tags : [Code, quantstrat, R]
---

The complaint I hear most frequently about quantstrat is that it's slow, especially for large data.  Some of this slow performance is due to quantstrat treating all strategies as path-dependent by default.  Path dependence requires rules to be re-evaluated for each timestamp with a signal.  More signals equates to longer run-times.  
  
If your strategy is not path-dependent, you can get a fairly substantial performance improvement by turning path-dependence off.  If your strategy truly is path-dependent, keep reading...  
  
I started working with Brian Peterson in late August of this year, and we've been working on a series of very large backtests over the last several weeks.  Each backtest consisted of ~7 months of 5-second data on 72 instruments with 15-20 different configurations for each.  
  
These backtests really pushed quantstrat to its limits.  The longest-running job took 32 hours.  I had some time while they were running, so I decided to profile quantstrat.  I was able to make some substantial improvements, so I thought I'd write a post to tell you what's changed and highlight some of the performance gains we're seeing.  
  
The biggest issue was how the internal function **ruleProc** was constructing and evaluating the rule function call for each signal.  Basically, the code that constructed the call was evaluating the **mktdata** object before calling the rule function.  This meant that the rule function call looked like this:  

> **ruleFunction(c(50.04, 50.23, 50.42, 50.37, 50.24, 50.13, 50.12, 50.42, 50.42, 50.37, 50.24, 50.22, 49.95, 50.23, 50.26, 50.22, 50.11, 49.99, 50.12, 50.4, 50.33, 50.33, 50.18, 49.99), ...)**

instead of this:  

> **ruleFunction(mktdata, ...)**

You can only imagine how large that first call would be for a 10-million-row **mktdata** object.  Changing the rule function call to use the name (symbol) of the **mktdata** object instead of the **mktdata** object itself helped the 32-hour job finish in just over 2 hours.  
  
If you think I would be happy enough with that, you don't know me.  Several other changes helped get that 2-hour run down to under 30 minutes.  

*   We now calculate **periodicity(mktdata)** in **applyRules** and pass that value to **ruleOrderProc**.  This avoids re-calculating that value for every order, since **mktdata** doesn't change inside **applyRules**.

*   We also pass current row index value to **ruleOrderProc** and **ruleSignal** because xts subsetting via an integer is much faster than via a POSIXct object.

*   **applyStrategy** only accumulates values returned from **applyIndicators**, **applySignals**, and **applyRules** if **debug=TRUE**.  This saves a little time, but can save a lot of memory for large **mktdata** objects.

*   The dimension reduction algorithm has to look for the first time the price crosses the limit order price.  We were doing that with a call to **which(sigThreshold(...))\[1\]**.  The relational operators (**<**, **<=**, **\>**, ****\>**\=**, and **\==**) and **which** operate on the entire vector, but we only need the first value, so I replaced that code with a with C-based **.firstThreshold** function that stops as soon as it finds the first cross.

All these changes are most significant for large data sets.  The small demo strategies included with quantstrat are also faster, but the net performance gains increase as the size of the data, the number of signals (and therefore the number of rule evaluations), and number of instruments increases.  
  
You're still reading?  What are you waiting for?  Go [install the latest from R-Forge](https://r-forge.r-project.org/R/?group_id=316) and try it for yourself!