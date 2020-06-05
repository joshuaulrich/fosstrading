---
title: 'Introducing IBrokers (and Jeff Ryan)'
date: 2010-05-13T14:23:00.030-05:00
draft: false
aliases: [ "/2010/05/introducing-ibrokers-and-jeff-ryan.html" ]
tags : [Interactive Brokers, HIstorical Data, IBrokers, R, API]
---

Josh had kindly invited me to post on FOSS Trading around the time when he first came up with the idea for the blog. Fast forward a year and I am finally taking him up on his offer.  
  

I'll start by highlighting that while all the software in this post is indeed _free (true to FOSS)_, an account with [Interactive Brokers](http://www.interactivebrokers.com/) is needed to make use of it. For those not familiar with IB, they offer a trading platform that excels on numerous fronts but is most appealing to those of us who trade algorithmically. IB makes available a rather comprehensive API that makes data access and trade execution entirely possible programmatically via a handful of "supported" languages. These include Java (the language of the platform), C#, VBA and even Excel. The also have a POSIX compliant C++ version for those who enjoy C++ but dislike Windows.  
  
For those who dislike Windows _and_ C++, the community of IB users have a few "non-official" options. They include some nice implementations in C, Python (2), Matlab, and something even more abstracted in the [trading-shim](http://www.trading-shim.org/). While all well and good, there was one missing: R.  
  
Many of you may know I am a rather large proponent of R. I have authored or coauthored quite a few packages and help to organize the [R/Finance conference](http://www.rinfinance.com/) in Chicago each Spring. I am also a huge single-language solution kind of guy. If I could order food and surf the internet from R, all the world would be mine. But I digress...  
  
The [IBrokers](http://cran.r-project.org/web/packages/IBrokers/index.html) package on CRAN is my contribution to the landscape. A pure R implementation of most of the API, using nothing but R and some magic. It is now possible to connect to a running TWS (aka Trader Workstation) and retrieve historical data, request market data feeds, and even place orders -- _all from R_.

  

You can get a TWS client from IB at the link above, and installing IBrokers is easy enough from R:

```
install.packages("IBrokers")
```

Next up would be to make sure that your TWS has sockets enable, and you have your localhost entered as a "trusted IP".

  

First find the "Configure" menu in the TWS

  

![](http://3.bp.blogspot.com/_MAIcNo33u88/S-xdZJVwruI/AAAAAAAAAGA/DrkSdoz7xUs/s320/Screen+shot+2010-05-13+at+3.10.05+195PM.png)

  

Next we check for "Enable ActiveX and Socket Clients"

  

[![](http://1.bp.blogspot.com/_MAIcNo33u88/S-xd-5mLPqI/AAAAAAAAAGI/KZBj-FGko6s/s320/Screen+shot+2010-05-13+at+3.10.30+142PM.png)](http://1.bp.blogspot.com/_MAIcNo33u88/S-xd-5mLPqI/AAAAAAAAAGI/KZBj-FGko6s/s1600/Screen+shot+2010-05-13+at+3.10.30+142PM.png)  

To add a "Trusted IP" click on "All API Settings..."

  

[![](http://1.bp.blogspot.com/_MAIcNo33u88/S-xfHKb6TQI/AAAAAAAAAGQ/7k0aAxN_Wzo/s320/Screen+shot+2010-05-13+at+3.10.43+749PM.png)](http://1.bp.blogspot.com/_MAIcNo33u88/S-xfHKb6TQI/AAAAAAAAAGQ/7k0aAxN_Wzo/s1600/Screen+shot+2010-05-13+at+3.10.43+749PM.png)

  

Okay, that was easy. Now we are back to R code. Next we need to load our freshly installed IBrokers package and connect.

```
library(IBrokers)

## Loading required package: xts
## Loading required package: zoo
## IBrokers version 0.2-7: (alpha)
## 
## Implementing API Version 9.62
## 
## This software comes with NO WARRANTY. Not intended for production use!
## 
## See ?IBrokers for details

tws <- twsConnect()
tws

## <twsConnection,1 @ 20100513 15:11:40 CST, nextId=1288>
```

As you can see there isn't too much to talk about in the code above. We make the standard R library() call to get IBrokers into our session, and the use the twsConnect function to make a connection to the TWS. There are parameters that can be passed in (such as host, and connection ID), but we needn't do that here.  

  

The result of our call is a _twsConnection_ object. This contains a few important bits of information that are used throughout the lifetime of the object.  

  

To wrap up this post we'll use our new connection to fetch some historical data from IB.

```
aapl <- reqHistoricalData(tws, twsSTK("AAPL"))

## TWS Message: 2 -1 2104 Market data farm connection is OK:usfuture
## 
## TWS Message: 2 -1 2104 Market data farm connection is OK:usfarm
## 
## waiting for TWS reply ....... done.
```

Some notes about the above. The first argument to most any IBrokers call is the connection object created with twsConnect. The second argument to the above request is a twsContract object. There are a variety of ways to construct this, and twsSTK is just a shortcut from IBrokers that allows for equity instruments to be specified. The object is just a list of fields that contain data IB needs to process your requests:

```
twsSTK("AAPL")

## List of 14
## $ conId : num 0
## $ symbol : chr "AAPL"
## $ sectype : chr "STK"
## $ exch : chr "SMART"
## $ primary : chr ""
## $ expiry : chr ""
## $ strike : chr "0.0"
## $ currency : chr "USD"
## $ right : chr ""
## $ local : chr ""
## $ multiplier : chr ""
## $ combo_legs_desc: NULL
## $ comboleg : NULL
## $ include_expired: chr "0"
```

As you may have noticed, we assigned the output of our request to a variable **appl** in our workspace. Taking a look at it reveals it is an xts object of our daily bars for the last 30 calendar days.

```
str(aapl)

## An ‘xts’ object from 2010-04-14 to 2010-05-13 containing:
##   Data: num [1:22, 1:8] 245 246 249 247 248 ...
##  - attr(*, "dimnames")=List of 2
##   ..$ : NULL
##   ..$ : chr [1:8] "AAPL.Open" "AAPL.High" "AAPL.Low" "AAPL.Close" ...
##   Indexed by objects of class: [POSIXt,POSIXct] TZ: America/Chicago
##   xts Attributes:
## List of 4
##  $ from : chr "20100413 21:35:34"
##  $ to : chr "20100513 21:35:34"
##  $ src : chr "IB"
##  $ updated: POSIXct[1:1], format: "2010-05-13 15:35:36.396084"
```

The _reqHistoricalData_ call takes a few arguments that can specify the **barSize** and **duration** of the data that is returned. Be warned that not all combinations work, not all working combinations are applicable to all contract types, and there are strict limits on how many queries you can make in any time period. These are IB enforced limitations and often are a source of great frustration when trying to reconcile why your simple request has failed. More information regarding the details of what works and when can be found in the [IBrokers documentation,](http://cran.r-project.org/web/packages/IBrokers/IBrokers.pdf) as well as the more authoritative [reference](http://www.interactivebrokers.com/php/apiUsersGuide/apiguide/api/historical_data_limitations.htm) from IB.  
  
Next time we'll explore the real-time data features of IBrokers, including live market data, real-time bars, and order-book data capabilities.
