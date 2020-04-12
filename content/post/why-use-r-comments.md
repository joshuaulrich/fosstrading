---
title: 'Why Use R?'
date: 2010-12-14T22:35:00.000-06:00
draft: false
aliases: [ "/2010/12/why-use-r.html" ]
tags : [R]
---

#### I really like this post because you show a progres...
[Phil Rack](https://www.blogger.com/profile/07842410006404236423 "noreply@blogger.com") - <time datetime="2010-12-15T09:57:04.588-06:00">Dec 3, 2010</time>

I really like this post because you show a progression of stat tools you have used. I think that's important for those who are considering using a new product. Everyone wants to see some common ground and how they've evolved their analytics stack over time.
<hr />
#### One thing I can't seem to figure out in R is h...
[Unknown](https://www.blogger.com/profile/05184052402836061278 "noreply@blogger.com") - <time datetime="2010-12-15T12:05:11.257-06:00">Dec 3, 2010</time>

One thing I can't seem to figure out in R is how you would use multiple timeframes. Let's say you want to look at both daily and intraday data as part of the same study (daily to trigger entry, and intraday to figure out if your limit or stop is hit first). The only way I can figure out how to do this is using loops to keep daily and intraday "synchronized" - and that seems to slow everything to a crawl. Is there an easy solution to this that maintains R's high speed time series without resorting to loops? I'm admittedly an R newbie. Thanks!
<hr />
#### R has many idiosyncrasies and it does not optimize...
[Alex Rad](https://www.blogger.com/profile/16317387272669249759 "noreply@blogger.com") - <time datetime="2010-12-17T20:06:39.756-06:00">Dec 6, 2010</time>

R has many idiosyncrasies and it does not optimize well for certain matrix operations. The documentation is also quite poor.  
  
In terms of performance, numpy+python can knock down the best optimized programs. And in terms of comprehension, numpy+python wins again
<hr />
#### Phil, thanks for the comment. I'm glad you li...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-12-17T20:52:10.661-06:00">Dec 6, 2010</time>

Phil, thanks for the comment. I'm glad you liked the post.  
  
Scott, I'm not sure I understand your question. You will probably get some good answers if you send an example of what you want to the [R-SIG-Finance mailing list](https://stat.ethz.ch/mailman/listinfo/r-sig-finance) (follow the [posting guide](http://www.r-project.org/posting-guide.html) to get the best answers).  
  
Alex, which matrix operations does R not optimize well? Using which BLAS? How is the documentation poor? Can you cite some performance comparison examples? How long have you used R? Python? Thanks for the comment.
<hr />
