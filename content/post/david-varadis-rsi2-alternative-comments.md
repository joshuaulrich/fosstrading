---
title: 'David Varadi''s RSI(2) alternative'
date: 2009-07-19T08:38:00.003-05:00
draft: false
aliases: [ "/2009/07/david-varadis-rsi2-alternative.html" ]
tags : [Code]
---

#### hello josh, If I want to sell the stock when the R...
[Bear](https://www.blogger.com/profile/10301431975043826550 "noreply@blogger.com") - <time datetime="2009-07-23T16:57:04.533-05:00">Jul 4, 2009</time>

hello josh,  
If I want to sell the stock when the RSI retereat from the 90 or buy it when the RSI above 10 again how can I modify the code?
<hr />
#### Hi Bear, You need to use a lagged value of RSI in...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-07-24T13:09:55.203-05:00">Jul 5, 2009</time>

Hi Bear,  
  
You need to use a lagged value of RSI in addition to the current value. The code below shows how to do it.  
  
**library(TTR)  
price <- .xts(20\*cumprod(1+rnorm(50)/100),Sys.Date()-50:1)  
rsi <- RSI(price,2)  
rsiLag <- lag(rsi)  
sig <- rep(0,50)  
sig <- ifelse(rsiLag > 90 & rsi < 90, -1, sig)  
sig <- ifelse(rsiLag < 10 & rsi > 10, 1, sig)**  
  
So **sig** will be '1' if yesterday's RSI (**rsiLag**) is less than 10 and today's RSI (**rsi**) is greater than 10.  
  
Hope that helps,  
Josh
<hr />
#### Thanks Actually I am testing RSI(price,14), so th...
[Bear](https://www.blogger.com/profile/10301431975043826550 "noreply@blogger.com") - <time datetime="2009-07-24T15:50:08.453-05:00">Jul 5, 2009</time>

Thanks  
Actually I am testing RSI(price,14), so the indicator may be under 20 or above 80 for a time and I use FOR loop instead of ifelse and lag but FOR is slow in R.  
  
Is there any better solution?
<hr />
#### The solution I posted above is better. You just h...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-07-24T16:56:00.679-05:00">Jul 5, 2009</time>

The solution I posted above is better. You just have to change the "n" for the RSI function to "14" and the upper and lower bounds in the ifelse() statements to 80 and 20.
<hr />
#### Hello Joshua, Is there a reason why the result is ...
[Unknown](https://www.blogger.com/profile/17745443780811874563 "noreply@blogger.com") - <time datetime="2010-02-17T16:05:42.079-06:00">Feb 3, 2010</time>

Hello Joshua,  
Is there a reason why the result is sometimes of typeof "list" instead of "doubles" ?  
  
When I load my datas from 1970 with quantmod the result is typeof "list"; and when I start from 1980 the result is typeof "double".  
  
Thank you.
<hr />
#### jipibelanger, The result should always be an xts ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-02-17T21:13:23.737-06:00">Feb 4, 2010</time>

jipibelanger,  
  
The result should always be an xts object. I'm not sure how you're getting a "list", but the high / low data prior to 1980 is poor for most Yahoo data.
<hr />
