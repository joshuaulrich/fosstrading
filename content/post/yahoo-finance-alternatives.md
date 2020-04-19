---
title: 'Yahoo Finance Alternatives'
date: 2017-06-07T12:20:00.001-05:00
draft: false
aliases: [ "/2017/06/yahoo-finance-alternatives.html" ]
tags : [HIstorical Data]
---

I assume that you're reading this because you are one of many people who were affected by the changes to Yahoo Finance data in May (2017).  Not only did the URL change, but the actual data changed as well!  
  
The most noticeable difference is that the adjusted close column is now only split-adjusted, whereas it used to be split- and dividend-adjusted.  Another oddity is that only the close prices is unadjusted (strangely, the open, high, and low are split-adjusted).  
  
All these issues can be dealt with using tools that are currently available.  For example, you can unadjust the open, high, and low prices using the ratio of close to adjusted close prices.  And you can adjust for both splits and dividends using `quantmod::adjustOHLC()`.  
  
Unfortunately, there also appear to be issues with data quality.  Some instruments have rows where all the prices and volume are zeros (e.g. [XLU](https://finance.yahoo.com/quote/XLU/history?period1=1417672800&period2=1422079200&interval=1d&filter=history&frequency=1d)).  The adjusted close in some instruments is incorrect because of missing split events, or double-counting splits and special dividends.  
  
So, what are your alternatives?  If you're just tinkering, you can try other free data sources like [Google Finance](https://www.google.com/finance) or [Quandl](https://www.quandl.com/).  Note that Google Finance data is already split-adjusted, so you might need to adjust for dividends, or un-adjust for splits, depending on your needs.  Quandl has a [wiki of end-of-day stock prices](https://www.quandl.com/data/WIKI-Wiki-EOD-Stock-Prices) curated by the community.  You only need a free account to access the data.  
  
If you're using the data to make actual investment decisions, you should really be using a professional data provider.  At the very least, you get someone to yell at when the data have errors. :)  First, you should check if your broker provides the historical data you need (e.g. [Interactive Brokers](https://www.interactivebrokers.com/) provides historical and real-time data to account-holders).  

If your broker doesn't provide historical data, here are a few providers you may want to consider:
  
[Tiingo](https://api.tiingo.com/)  
* Free historical end-of-day data (registration and API key required)  
* Up to 50+ years of daily data (split and dividend adjusted) for over 65,000 equities, mutual funds, and ETFs  
* Free historical and real-time crypto data (4+ year of daily prices, 2+ years of intraday data)  
* Free historical and real-time intraday data from IEX, beginning in August 2017  
* [Available via `getSymbols()`](http://blog.fosstrading.com/2018/04/goodbye-google-hello-tiingo.html)  

  

[Alpha Vantage](https://www.alphavantage.co/)  
* Free historical and intraday equity data (registration and API key required)  
* Up to 20 years of daily data (split and dividend adjusted available)  
* Up to 10 days of intraday data (1min, 5min, 15min, 30min, 60min)  
* [Available via `getSymbols()`](http://blog.fosstrading.com/2017/10/getsymbols-and-alpha-vantage.html)  
  

[eoddata](http://www.eoddata.com/download.aspx)
* Provide limited historical data for free
* For a one-time fee:
    * $20-$50 for 10 years of daily data
    * $40-$100 for 20 years of daily data

[CSI Data](https://www.csicheckout.com/cgi-bin/ua_order_form_nw.pl?referrer=JU) **\***
* Massive historical equity database
* $600 annually for 30 years of daily data
* Ability to adjust for splits and dividends

[IQFeed](http://www.iqfeed.net/)
* Mainly a real-time data provider, but also has historical data
* [Features](http://www.iqfeed.net/index.cfm?displayaction=data&section=services)
* [Pricing](http://www.iqfeed.net/index.cfm?displayaction=data&section=fees), starts at $78/month

Leave a comment if you know of another end-of-day data provider that I didn't list!

**\* FULL DISCLOSURE**: I receive a referral fee for annual subscriptions to CSI products if you use the FOSS coupon code.
