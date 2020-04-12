---
title: 'Historical / Future Volatility Correlation Stability'
date: 2010-04-11T12:53:00.002-05:00
draft: false
aliases: [ "/2010/04/historical-future-volatility.html" ]
tags : [TTR, Code]
---

#### I've noticed odd behaviour like this before in...
[Unknown](https://www.blogger.com/profile/11359134957413339223 "noreply@blogger.com") - <time datetime="2010-05-30T00:59:00.544-05:00">May 0, 2010</time>

I've noticed odd behaviour like this before in correlations (the swings in the 252 day vols from -1/+1); in this case the effect probably due to the lack of independence of the variables in use. that is, your bottom plot for 1 year historical/future really only has 40 independent points, the rest are (auto)correlated. likewise, when computing the correlation of two rolling series with high degrees of autocorrelation, the correlations get screwy.
<hr />
#### sorry, it was late when I commented, and this was ...
[Unknown](https://www.blogger.com/profile/11359134957413339223 "noreply@blogger.com") - <time datetime="2010-06-01T00:19:04.835-05:00">Jun 2, 2010</time>

sorry, it was late when I commented, and this was not terribly clear. here's the major problem: given series x\_i, y\_i, the sample correlation is an unbiased estimate of the population correlation when the x\_i are independent of each other and the y\_i are independent of each other. when they are not, as in the case of rolling 252 period standard deviations, with x\_i having 251 period overlap with x\_{i+1}, the sample correlation is meaningless, as you have found.  
  
you can test this Monte Carlo style; generate 1000 normal iid variates X, and independently generate the same number of Y; compute the 250 period rolling stdevs. then compute the correlation between the two series of stdevs. repeat this 5000 times. the distribution of correlations will have standard error about zero much wider than suggested by R-Z transform. hth,
<hr />
