---
title: 'Creating Financial Instrument metadata in R'
date: 2011-07-27T22:16:00.003-05:00
draft: false
aliases: [ "/2011/07/creating-financial-instrument-metadata.html" ]
tags : [Data, R]
---

#### Should we consider it good that rules are independ...
[Anonymous]( "noreply@blogger.com") - <time datetime="2011-08-29T10:04:52.310-05:00">Aug 1, 2011</time>

Should we consider it good that rules are independent of model building? I don't think so. My goal in backtesting is to assign a PROBABILITY that a trade will move my favour -- and then size according to modified Kelly.
<hr />
#### @crasshopper: I think it would be more appropriate...
[Brian G. Peterson](https://www.blogger.com/profile/09226525229201110236 "noreply@blogger.com") - <time datetime="2011-09-08T08:06:00.146-05:00">Sep 4, 2011</time>

@crasshopper: I think it would be more appropriate to say that rules are ipart of the model, and that models are independent of the instruments that they will be applied to. Nothing in this is antithetical to trade sizing with a LSPM or modified Kelly methodology once you are able to quantify your edge based on your backtests and production tests on small lot sizes.
<hr />
