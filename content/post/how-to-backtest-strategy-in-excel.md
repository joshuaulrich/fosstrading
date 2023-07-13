---
title: 'How to backtest a strategy in Excel'
date: 2011-03-14T20:57:00.000-05:00
draft: false
aliases: [ "/2011/03/how-to-backtest-strategy-in-excel.html" ]
categories: [ Articles ]
tags : [Examples, Excel, R]
---

(This is a guest post by Damian from [Skill Analytics](http://skillanalytics.wordpress.com/) and [ETF Prophet](http://www.etfprophet.com/))

  

Let me start by saying that I’m not an expert in backtesting in Excel – there are a load of very smart bloggers out there that have, as I would say, “mad skillz” at working with Excel including (but not limited to) Michael Stokes over at [marketsci.com](http://blog.marketsci.com/), Jeff Pietch over at [etfprophet.com](http://www.etfprophet.com/) and the folks (David and Corey) over at [cssanalytics.wordpress.com](http://cssanalytics.wordpress.com/). All of these guys have been gracious enough, over the years, to share with me how to do backtests – so I am indebted to them. And I want to thank Josh here at FOSS Trading as well – because he’s been kind enough to help me in learning how to use R for testing.

  

With all that in mind, I thought I’d walk through what I consider the four basic steps in producing a backtest in Excel. Note that the [core Excel file](http://dl.dropbox.com/u/17693/DVI%20long-short.xlsx) wasn't created by me - it was created by Jared over at [CondorOptions](http://www.condoroptions.com/) (another must read if you're not following him).

  

**Step 1: Get the data**

The first step is to get your market data into Excel. There are two basic approaches to this – the first involves going to Yahoo Finance and downloading historical data directly as CSV and then loading it into Excel. This is nice, but does require a manual update of that data as you go forward – meaning, you’ll need to re-download that historical data and then copy and paste either the entire dataset or a subset to update your strategy.

  
The second approach is to use code to go grab data automatically from Yahoo Finance. Plenty of people have written VBA for doing just this – I have not written it myself so I don’t feel comfortable republishing the code. A quick search on Google will provide some examples to work with. There are also 3rd party tools that make the job simple – I’d recommend [AnalyzerXL](http://www.analyzerxl.com/) as it provides the most flexibility and options.

  

How you store this data in Excel is up to you – most people I know have a single sheet where they keep all the data, and then have a separate worksheet for the rest of system. For systems with a single instrument (such as the SPY), it’s not a problem to integrate the data and the system, but as the number of instruments goes up, you’ll want to have them on a separate worksheet to minimize scrolling and make it easy to update.

  

**Step 2: Create your indicator**

Now that we’ve got the data, we can use that data to construct an indicator or indicators. In this example, Jared constructed the DVI indicator (originally created by David over as CSS Analytics). You’ll see that we used 5 different columns to create the indicator – each one taking part of the calculation. One nice thing about working with Excel is that it really makes you think about how an indicator is constructed. It can be far too simple, these days, to throw down and indicator without understanding how it actually works.

  

The final indicator column, DVI, is a weighted sum of the DVI magnitude and DVI stretch columns. I’d also note that AnalyzerXL also contains a large number of indicators predefined to make backtesting easier, and there are other add-ons for Excel that provide similar functionality.

  

**Step 3: Construct your trading rule**

Now that you have an indicator, you need to construct your trading rules. In this example (calculation is in the “Signal” column), our trading rule is simple – we’re long if DVI is below 0.5 and short if above. Obviously you could have more complex rules – a neutral state where you’re not long or short, or variable position sizing as opposed to just all-in long or short.

  
**Step 4: The trading rules/equity curve**

There are many different approaches here, but what you can see in this example is a simple way to do it. Assume a starting cash value of $10,000 and then increment or decrement that by whether or not we are long or short on the close of the prior day, and whether we were correct or not. In function form, we represent this by saying: if long, then multiple the prior day’s equity by the ratio of today’s close to yesterday’s close, otherwise multiple the prior day’s equity by ratio of yesterday’s close to today’s close. We can then, obviously, graph the results. Note also that we’re using cash here, but you could easily do raw percentages in place of a cash value.

  

What’s missing here can be important for deciding whether to trade or not trade a system. First of all, the results here are frictionless – they assume there is no cost/commission for the trade. In high frequency swing systems like this one, the commissions could have a major impact on the viability of a given strategy.

  

Second, we don’t have any statistics on the performance of the strategy – just a graph. Generally we want to know stats like CAGR and the Sharpe ratio to compare it with other strategies. We also don’t have monthly or yearly reporting. All of these things can be constructed in Excel with a bit of work – and again, AnalyzerXL provides a large number of reporting options as part of the package.

  

That's a basic overview of backtesting in Excel - hope that you all find it useful!
