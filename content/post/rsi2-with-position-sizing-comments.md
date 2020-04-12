---
title: 'RSI(2) with Position Sizing'
date: 2009-05-01T20:58:00.011-05:00
draft: false
aliases: [ "/2009/05/rsi2-with-position-sizing.html" ]
tags : [Examples, Code]
---

#### i look forward to it -- never could get my head ar...
[Autore del blog](https://www.blogger.com/profile/08536859794554569165 "noreply@blogger.com") - <time datetime="2009-05-02T19:29:00.000-05:00">May 0, 2009</time>

i look forward to it -- never could get my head around performance metrics..
<hr />
#### This is awesome - very cool. I also was curious i...
[Damian](https://www.blogger.com/profile/16016686632386396090 "noreply@blogger.com") - <time datetime="2009-05-15T11:52:00.000-05:00">May 5, 2009</time>

This is awesome - very cool. I also was curious if you could put together a simple example of the following:  
  
\- Take four ETFs (SPY,IWM,QQQQ,TLT) and rank them by their 12m ROC.  
\- Buy the top one on the first day of the month.  
\- Rerank at the beginning of each month, sell the fund if it has fallen from the top position and buy the new top position.  
  
Thanks much!
<hr />
#### Hi Damian, I'll keep that in mind for when we sta...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-05-16T10:59:00.000-05:00">May 6, 2009</time>

Hi Damian,  
  
I'll keep that in mind for when we start showing some more complicated trading systems and portfolio management using another package, 'blotter'.  
  
You can see a demo of the blotter package by installing it, attaching it (via 'library()'), and running 'demo(turtles)'.  
  
Please do note that the blotter package is still in heavy development, so many things will probably change. Such is life on the bleeding edge. :)
<hr />
#### Thank you very much for the informative post. I wa...
[Unknown](https://www.blogger.com/profile/02804157233788845545 "noreply@blogger.com") - <time datetime="2009-06-19T07:53:50.603-05:00">Jun 5, 2009</time>

Thank you very much for the informative post. I was wondering if you knew of any limitations this code would have when we do not use the getSymbols quantmod function and instead use imported Bloomberg data.  
  
I have found that the results from Bloomberg data differ highly from the results you've posted.  
  
I think that this problem may be due to how RSI and ROC calculate the signals and returns respectively.  
  
Any advice or suggestions would be awesome. Thanks in advance.  
  
Sean
<hr />
#### Hi Sean, It's really hard to say, without mor...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-06-24T13:53:30.324-05:00">Jun 3, 2009</time>

Hi Sean,  
  
It's really hard to say, without more information. Here are the things I would expect to cause differences:  
  
\- actual data differences between Yahoo and Bloomberg  
  
\- data object differences (i.e. getSymbols returns an xts object, the function you use to pull Bloomberg data may return a data.frame, matrix, etc.)
<hr />
#### Thanks Josh, I found that the problem lies in how ...
[Unknown](https://www.blogger.com/profile/02804157233788845545 "noreply@blogger.com") - <time datetime="2009-07-02T16:50:54.790-05:00">Jul 4, 2009</time>

Thanks Josh, I found that the problem lies in how the lag operator works. I posted a similar problem to the R Finance Community and the error should be corrected in the new version of quantmod.  
  
To quote Jeff:  
"lag.zoo was designed by Achim and Kurt to map as closely as possible to R's ts class behavior, which by all rational interpretations is simply inconsistent with the common understanding of lagged series. Zoo's goal was a better ts; xts is a time-based zoo.  
  
That said, lag.xts makes a break from this R lag "design" and implements a different set of default behavior, more consistent with user expectations IMO.  
  
Take a look at ?lag.xts  
  
Obviously the downside is management of this difference amongst time classes."  
  
Thanks again
<hr />
