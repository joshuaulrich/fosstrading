---
title: 'Maximum Probability of Profit'
date: 2010-04-09T10:04:00.001-05:00
draft: false
aliases: [ "/2010/04/maximum-probability-of-profit.html" ]
tags : [Examples, LSPM]
---

#### Josh, Thanks for another great explanation. I migh...
[Ralph Vince](https://www.blogger.com/profile/09541112958712768617 "noreply@blogger.com") - <time datetime="2010-04-09T14:39:18.666-05:00">Apr 5, 2010</time>

Josh, Thanks for another great explanation. I might point out to that it is not just the optimization algorithms used, but in the case of mazimizing for greatest probability of profit, there are many posssible optimal sets (f1,..,fn,z+,z-). There are multiple sets which will result in an equivalent (and highest) probability of profit.  
\-Ralph Vince
<hr />
#### If I understand the optimization problem correctly...
[Matthew](https://www.blogger.com/profile/09927103458268901583 "noreply@blogger.com") - <time datetime="2010-04-17T19:38:32.639-05:00">Apr 0, 2010</time>

If I understand the optimization problem correctly, I think it may be possible to achieve similar results in just minutes of computation with a different optimization approach. How long does it take to evaluate the fitness of one LSPM allocation?  
  
Here is an example optimizer that is designed to find pretty globally optimal allocations while you wait: http://www.riskcog.com/portfolio-theme2.jsp#5e80e8d
<hr />
#### Matthew, The link you posted finds optimal alloca...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-04-18T23:16:29.536-05:00">Apr 1, 2010</time>

Matthew,  
  
The link you posted finds optimal allocations, but I don't see how to apply any constraints. An unconstrained LSPM geometric growth optimization only takes a few seconds.  
  
Also, the example in this post doesn't find the **_growth_**\-optimal allocation. Instead, it finds one--of potentially many--allocations that maximizes the probability of profitability, which is very different than a growth-optimal allocation.
<hr />
#### 
[Yves22](https://www.blogger.com/profile/05333353605716501383 "noreply@blogger.com") - <time datetime="2010-06-17T09:40:22.824-05:00">Jun 4, 2010</time>

This comment has been removed by the author.
<hr />
#### Hello Josh, Not yet up to speed with R myself cou...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-11T02:32:52.183-05:00">Aug 4, 2011</time>

Hello Josh,  
  
Not yet up to speed with R myself could I ask if you are quickly able to pin point why the following error message is currently being produced:  
  
\> # Drawdown-constrained maximum probability of profit (results on p. 173)  
\> res <- maxProbProfit(port, 1e-6, 12, probDrawdown, 0.1,  
\+ DD=0.2, calc.max=4, snow=cl, control=DEctrl)  
Error in function (VTR = -Inf, strategy = 2, bs = FALSE, NP = NA, itermax = 200, :  
unused argument(s) (refresh = 1, digits = 6)  
  
With thanks, Grant
<hr />
#### Hi Grant, The **refresh** parameter was rename...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-08-11T05:45:34.715-05:00">Aug 4, 2011</time>

Hi Grant,  
  
The **refresh** parameter was renamed to **trace**, and the **digits** parameters was removed in recent versions of DEoptim.  
  
Create the **DEctrl** object using this line of code instead:  
_DEctrl <- list(NP=np, itermax=11, trace=1, initial=initpop)_
<hr />
#### Spot on! My thanks Josh.
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-08-11T06:02:14.583-05:00">Aug 4, 2011</time>

Spot on! My thanks Josh.
<hr />
