---
title: 'LSPM Joint Probability Tables'
date: 2010-05-18T22:30:00.004-05:00
draft: false
aliases: [ "/2010/05/lspm-joint-probability-tables.html" ]
tags : [Examples, LSPM]
---

#### Josh, If I may comment: The joint probabilities ta...
[Ralph Vince](https://www.blogger.com/profile/09541112958712768617 "noreply@blogger.com") - <time datetime="2010-05-19T07:29:08.797-05:00">May 3, 2010</time>

Josh, If I may comment:  
The joint probabilities table ("jpt") ultimately should encompass and be a proxy for all potential risk for the next period.  
  
In other words, frequently, in attempting to articulate "risk," we see the argument that it is more than mere variance. That there is liquidity risk, there is counter-party risk, this risk and that risk, and there is a notion that risk posses many facets.  
  
The jpt _should_ attempt to encompass all that, so that we have one matrix that presents to us the many (and many unforseen) aspects of risk.  
  
To that end, my advice is to _start_ with the empirical distribution of prices, of outcomes, of what _has_ happened. Then, amend that table to incorporate any other facets of risk.  
  
One might argue that his is therefore only an "estimate," and that the outcomes of the model are therefore only estimates. And this is entirely true, and, as we can assume, the outputs are only as good as the estimates.  
  
But things _must_ be estimated. There is no getting around that in this business. The jpt allows us to incorporate these estimates into a composite picture of our total risk.
<hr />
#### Ralph, That's a very good point. The above c...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-19T08:06:39.293-05:00">May 3, 2010</time>

Ralph,  
  
That's a very good point. The above code only produces an estimate of the empirical distribution of outcomes, based on actual historical data.  
  
You can amend the maximum losses (maxLoss) of a **lsp** object via something like:  
_jpt$maxLoss\[1:3\] <- rep(-0.6,3)_  
  
I should probably write methods to append events / probabilities to the jpt. Something like:  
_\# This won't work right now  
jpt <- c(jpt,rep(-0.8,3))_
<hr />
#### 
[G$](https://www.blogger.com/profile/01349972242888715865 "noreply@blogger.com") - <time datetime="2010-05-19T21:14:43.631-05:00">May 4, 2010</time>

This comment has been removed by the author.
<hr />
#### G$, This isn't an appropriate place to discus...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-05-19T21:24:57.153-05:00">May 4, 2010</time>

G$,  
  
This isn't an appropriate place to discuss issues with your R installation.
<hr />
#### Hey Josh, this looks great (or at least I'm su...
[Anonymous]( "noreply@blogger.com") - <time datetime="2010-05-23T01:25:26.113-05:00">May 0, 2010</time>

Hey Josh, this looks great (or at least I'm sure that it will once I work out how to use it).  
  
I am a big fan of using csv files for data input/output, and perhaps it might be worth giving some consideration to dropping the JPT out as a csv for editing purposes and then it can be imported directly into LSPM. That would conveniently tie the 2 tasks (JPT / LSPM) together.  
  
My current task is to figure out how to import the raw data into this code from a csv.  
  
Ross Bond
<hr />
#### Joshua - looked for a contact email address - coul...
[Damian](https://www.blogger.com/profile/16016686632386396090 "noreply@blogger.com") - <time datetime="2010-06-03T14:54:39.259-05:00">Jun 4, 2010</time>

Joshua - looked for a contact email address - couldn't find one. Would love to get your opinion on:;  
  
http://www.monkeyanalytics.com  
  
It'd be great to get a setup with them that was targeted to FOSS traders.  
  
Thanks!
<hr />
#### Damian, Sorry about the contact email address. Y...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-06-05T18:43:34.359-05:00">Jun 6, 2010</time>

Damian,  
  
Sorry about the contact email address. You can find it in my R packages...  
  
Monkey Analytics looks interesting. It seems like they're setting up an EC2 cluster for you so you don't have to do as much of the administrative stuff. They're not currently accepting users, so I can't investigate much. It may be very useful for people who want to run LSPM but don't have / want their own cluster.
<hr />
#### Hi Joshua, Following Ralph's comment, regardi...
[Kostas](https://www.blogger.com/profile/18342292975184838052 "noreply@blogger.com") - <time datetime="2011-09-06T23:26:36.101-05:00">Sep 3, 2011</time>

Hi Joshua,  
  
Following Ralph's comment, regarding the creation of the jpt do you have in mind a way to "blend" jpts maybe created from two different periods? Say you want to incorporate with a certain probability two jpts, one of a more recent period and one of a period of crisis or something similar.  
  
many thanks  
Kostas Metaxas
<hr />
#### Hi Kostas, There currently isn't a function t...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-09-09T20:39:23.506-05:00">Sep 6, 2011</time>

Hi Kostas,  
  
There currently isn't a function to join JPTs, but you can do it by hand:  
  
_library(LSPM)  
data(port)  
port\_rows <- port\_cols <- port  
  
\# combine JPTs by rows  
port\_rows$events <- rbind(port\_rows$events, port$events)  
port\_rows$probs <- rbind(port\_rows$probs, port$probs)  
  
\# combine JPTs by columns  
port\_cols$events <- cbind(port\_cols$events, port$events)  
port\_cols$maxLoss <- c(port\_cols$maxLoss, port$maxLoss)  
port\_cols$f <- c(port\_cols$f, port$f)  
_
<hr />
#### Hi Josh, Relating to jointProbTable are the follo...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-03T20:13:34.975-05:00">Nov 5, 2011</time>

Hi Josh,  
  
Relating to jointProbTable are the following warning messages anything to be concerned about? Maybe there is some way to prevent the warnings?  
  
\> jpt <- jointProbTable(rtn,n=c(20,20,20))  
Warning messages:  
1: In is.na(cols) : is.na() applied to non-(list or vector) of type 'NULL'  
2: In is.na(cols) : is.na() applied to non-(list or vector) of type 'NULL'
<hr />
#### TradingPro, You haven't provided enough infor...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-04T21:05:57.649-05:00">Nov 6, 2011</time>

TradingPro,  
  
You haven't provided enough information for me to know if the warnings are anything to be worried about or if there's any way to prevent them. Please email me if you would like help looking into this.
<hr />
#### Hi Josh (this is Grant), Thank you for the reply a...
[TradingPro](https://www.blogger.com/profile/01987456606418594625 "noreply@blogger.com") - <time datetime="2011-11-07T16:50:52.492-06:00">Nov 1, 2011</time>

Hi Josh (this is Grant),  
Thank you for the reply and offer to help.  
It is okay for now then, I was presuming that this was a generic warning that everybody was receiving because I receive them on differing platforms and data.  
All appears to be fine but I will let you know if any issues surface.
<hr />
#### Josh I am now trying to create a jointProbability...
[Chris](https://www.blogger.com/profile/01276455562887525056 "noreply@blogger.com") - <time datetime="2011-11-29T14:36:24.315-06:00">Nov 2, 2011</time>

Josh  
  
I am now trying to create a jointProbability table of the pnl table you helped me to create in the "margin constraints with LSPM" thread. The data in "pnl" is normalized dollar values with 439 rows and 41 columns. I run the following command:  
  
  
(jpt <- jointProbTable(pnl,n=c(40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40,40)))  
  
and get:  
  
  
Error in if (any(maxLoss >= 0)) { : missing value where TRUE/FALSE needed  
In addition: Warning messages:  
1: In is.na(cols) : is.na() applied to non-(list or vector) of type 'NULL'  
2: In is.na(cols) : is.na() applied to non-(list or vector) of type 'NULL'  
  
Your help will be highly appreciated.  
  
Regards
<hr />
#### Hi Chris, I'm happy to help, but (as I mentio...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2011-11-29T16:43:32.711-06:00">Nov 2, 2011</time>

Hi Chris,  
  
I'm happy to help, but (as I mentioned to Grant in an earlier comment on this post) I would prefer to be emailed directly with questions that do not pertain to the post.  
  
I don't consider, "I got an error when I tried to use the function in your post, but I don't know why..." or "how do I do X" to pertain to the post, so I would prefer questions like that be emailed to me directly, _not_ posted as comments.  
  
I would consider, "line XYZ of function 'foo' causes an error when the input is like 'abc'" to pertain to the post, so I welcome those types of specific comments.
<hr />
