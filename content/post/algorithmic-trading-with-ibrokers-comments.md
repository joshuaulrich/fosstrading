---
title: 'Algorithmic Trading with IBrokers'
date: 2010-10-25T22:01:00.001-05:00
draft: false
aliases: [ "/2010/10/algorithmic-trading-with-ibrokers.html" ]
tags : [IBrokers]
---

#### As the speaker says, R isn't fast enough to do...
[Anonymous]( "noreply@blogger.com") - <time datetime="2010-10-31T15:19:07.375-05:00">Oct 0, 2010</time>

As the speaker says, R isn't fast enough to do HFT.  
  
You really think anybody can beat the market using the same statistics packages as everybody else and being charged $1/trade?!
<hr />
#### If by HFT, you mean is R fast enough to compete wi...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2010-10-31T18:59:07.644-05:00">Oct 0, 2010</time>

If by HFT, you mean is R fast enough to compete with Getco or Goldman, then the answer is clearly NO. That world is dominated by embedded computing, wire speed, and things like FPGA.  
  
The frequency of your indicators or signals may not require reacting and potentially moving an order on every trade. Many large investment banks, hedge funds, and trading firms use R extensively 'in production' for analytics on real-time streaming data.  
  
In those environments it is common to rewrite some things in C or C++ for speed, but many market makers use R to set the bid/ask spread that they are willing to work, or to calculate statistics like realized volatility that don't need to be updated every tick.  
  
Regards,  
  
\- Brian
<hr />
#### This is interesting however there are a couple of ...
[Unknown](https://www.blogger.com/profile/15869015257722630698 "noreply@blogger.com") - <time datetime="2010-11-17T12:39:40.791-06:00">Nov 3, 2010</time>

This is interesting however there are a couple of points I would make. You can live anywhere in the world and rent colo space in the right location which gives you access to the right IP, latency and exchange connectivity. You can call this Proximity Hosting, Low-Latency Trading, Automated Trading, Algorithmic Trading, High Frequency Trading if you want but you need to have a good colocation facility, broker account & Exchange Access. http://www.fcm360.com
<hr />
