---
title: 'Estimating Probability of Drawdown'
date: 2010-06-19T20:13:00.001-05:00
draft: false
aliases: [ "/2010/06/estimating-probability-of-drawdown.html" ]
tags : [LSPM, Drawdown]
---

#### Thanks for another great post Josh. I've looke...
[Ralph Vince](https://www.blogger.com/profile/09541112958712768617 "noreply@blogger.com") - <time datetime="2010-06-22T08:55:29.110-05:00">Jun 2, 2010</time>

Thanks for another great post Josh. I've looked at this at length. Remember -- the way you are calculating probability of drawdown, RD, is on a sample and replacement basis where the probabilities associated at each T to the horizon are unchanged. Thus, if, say, a large loss is seen at time T = t, the probablity of seeing that same large loss, in succession (i.e. at T = t+1), is the same as it was at T = t. The probability of drawdown using this method will give you the exact probability for these kinds of cases.  
However, in real life (again, depending on market, system trading time frame) your scenarios may be such that his is not the case -- and I suspect in the data you are using that it is not. In other words, the probability of any given scenario, (any given row in the joint probabilities table) arising is the same regardless of what the previous row was.  
Ultimately, the code you post here is a sort of test for dependency of exactly that(!) and may be even more interesting in its own right along those lines. -Ralph Vince
<hr />
#### Josh, Ah, I know why this is so -- and it has to ...
[Ralph Vince](https://www.blogger.com/profile/09541112958712768617 "noreply@blogger.com") - <time datetime="2010-09-02T07:21:05.246-05:00">Sep 4, 2010</time>

Josh,  
  
Ah, I know why this is so -- and it has to do with confidence intervals. I will explain this in detail in Tampa and it will make perfect sense.
<hr />
#### Hi Ralph, Thanks for the thoughts in both your co...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-09-02T21:10:11.221-05:00">Sep 5, 2010</time>

Hi Ralph,  
  
Thanks for the thoughts in both your comments. I look forward to the detailed explanation.
<hr />
#### Josh -- interesting paper that confirms perhaps wh...
[Ralph Vince](https://www.blogger.com/profile/09541112958712768617 "noreply@blogger.com") - <time datetime="2011-05-27T09:31:19.684-05:00">May 5, 2011</time>

Josh -- interesting paper that confirms perhaps what you are pointing out here, but from an altogether different standpoint: http://papers.ssrn.com/sol3/papers.cfm?abstract\_id=1850428
<hr />
