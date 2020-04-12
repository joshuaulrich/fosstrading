---
title: 'Introduction to quantstrat'
date: 2011-08-12T06:48:00.001-05:00
draft: false
aliases: [ "/2011/08/introduction-to-quantstrat.html" ]
tags : [quantstrat]
---

[quantstrat](http://r-forge.r-project.org/projects/blotter/) provides a generic infrastructure to model and backtest signal-based quantitative strategies.  It is a high-level abstraction layer (built on xts, FinancialInstrument, blotter, etc.) that allows you to build and test strategies in very few lines of code.  quantstrat is still under heavy development but is being used every day on real portfolios.  We encourage you to send contributions and test cases to the [project forums](http://r-forge.r-project.org/forum/?group_id=316).  
  
This post is a joint effort between me and [Brian Peterson](http://braverock.com/brian/).  It will describe the underlying philosophy of quantstrat and how quantstrat implements that philosophy.  You may have seen some of this in Brian's [Quantitative Strategy Development in R](http://www.rinfinance.com/agenda/2011/BrianPeterson.pdf) lightning talk at [R/Finance 2011](http://www.rinfinance.com/).  
  
**Generic Signal-Based Strategy Modeling**  
  
A signal-based strategy model first generates indicators.  Indicators are quantitative values derived from market data (e.g. moving averages, RSI, volatility bands, channels, momentum, etc.).  Indicators should be applied to market data in a vectorized (for fast backtesting) or streaming (for live execution) fashion, and are assumed to be path-independent (i.e. they do not depend on account / portfolio characteristics, current positions, or trades).  
  
The interaction between indicators and market data are used to generate signals (e.g. crossovers, thresholds, multiples, etc.).  These signals are points in time at which you _may_ want to take some action, even though you may not be able to.  Like indicators, signals may be applied in a vectorized or streaming fashion, and are assumed to be path-independent.  
  
Rules use market data, indicators, signals, and current account / portfolio characteristics to generate orders.  Notice that rules about position sizing, fill simulation, order generation / management, etc. are separate from the indicator and signal generation process.  Unlike indicators and signals, rules are generally evaluated in a path-dependent fashion (path-independent rules are supported but are rare in real life) and are aware of all prior market data and current positions at the time of evaluation.  Rules may either generate new or modify existing orders (e.g. risk management, fill, rebalance, entry, exit).  
  
**How quantstrat Models Strategies**  
  
quantstrat uses FinancialInstrument to specify instruments (including their currencies) and uses blotter to keep track of transactions, valuations, and P&amp;amp;L across portfolios and accounts.  
  
Indicators are often standard technical analysis functions like those found in TTR; and signals are often specified by the quantstrat sig\* functions (i.e. sigComparison, sigCrossover, sigFormula, sigPeak, sigThreshold).  Rules are typically specified with the quantstrat ruleSignal function.  
  
The functions used to specify indicators, signals, and rules are not limited to those mentioned previously.  The name parameter to add.indicator, add.signal, and add.rule can be _any_ R function.  Because the supporting toolchain is built using xts objects, custom functions will integrate most easily if they return xts objects.  
  
The strategy model is created in layers and makes use of delayed execution.  This means strategies can be applied--unmodified--to several different portfolios.  Before execution, quantstrat strategy objects do not know what instruments they will be applied to or what parameters will be passed to them.  
  
For example, indicator parameters such as moving average periods or thresholds are likely to affect strategy performance.  Default values for parameters may (optionally) be set in the strategy object, or set at call-time via the parameters argument of applyStrategy (parameters is a named list, used like the arguments lists).  
  
quantstrat models _orders_, which may or may not become transactions.  This provides a lot of extra ability to evaluate how the strategy is actually working, not working, or could be improved.  For example, performance strategies are often affected by how often resting limit orders are changed / replaced / canceled.  An order book allows the quantitative strategist to examine market conditions at the time these decisions are made. Also, the order history allows for easy computation of things that are important for many strategies, like order-to-fill ratios.  
  
**What's next?**  

*   Examples!  You can run some demos while you wait:  
      demo(package="quantstrat")
*   Strategy Evaluation
*   Parameter Evaluation