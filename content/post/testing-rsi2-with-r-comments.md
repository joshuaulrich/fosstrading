---
title: 'Testing RSI(2) with R, First Steps'
date: 2009-04-13T22:35:00.002-05:00
draft: false
aliases: [ "/2009/04/testing-rsi2-with-r.html" ]
tags : [Examples, Code]
---

#### Really cool. A lot of questions: "# Calcula...
[Damian](https://www.blogger.com/profile/16016686632386396090 "noreply@blogger.com") - <time datetime="2009-04-15T07:42:00.000-05:00">Apr 3, 2009</time>

Really cool. A lot of questions:  
  
"# Calculate the RSI indicator  
rsi <- RSI(Cl(GSPC),2)"  
  
When you reference the symbol for getting the data, you referenced it via "^GSPC" - how did it get assigned to GSPC?  
  
Secondly, if I have the data stored locally, how would I reference it?  
  
"# Lag signals to align with days in market,  
\# not days signals were generated  
sigup <- Lag(sigup)  
sigdn <- Lag(sigdn)"  
  
Why did you do this? Is this to buy/sell on the next day rather than current day the signal is generated?  
  
How do you know if you buying/selling on the open or close?  
  
"# Replace missing signals with no position  
\# (generally just at beginning of series)  
sigup\[is.na(sigup)\] <- 0  
sigdn\[is.na(sigdn)\] <- 0"  
  
This I don't understand at all....  
  
"# Calculate Close-to-Close returns  
ret <- ROC(Cl(GSPC))  
ret\[1\] <- 0"  
  
I'm guessing this is for the S&P comparison?  
  
"# Create a chart showing the S&P500  
chartSeries(GSPC, type="line")"  
  
Did you not show this chart?  
  
If you were working with a group of stocks:  
  
\- How would you work across a basket of stocks?  
\- Is it possible to produce a scan of those stock to show which ones meet the buy criteria when they are not backtested (meaning, as you go forward in time)?  
  
Very cool stuff - sorry for all the questions.
<hr />
#### Thanks for this great post. It was helpful to see...
[Unknown](https://www.blogger.com/profile/15482491081305577455 "noreply@blogger.com") - <time datetime="2009-04-16T19:15:00.000-05:00">Apr 5, 2009</time>

Thanks for this great post. It was helpful to see how to pull the tools together.
<hr />
#### Damian, Awesome questions! They really highlight...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-04-17T14:31:00.000-05:00">Apr 5, 2009</time>

Damian,  
  
Awesome questions! They really highlight how much I take for granted as a long-time R user...  
  
"^GSPC" is the Yahoo Finance ticker symbol, but R objects can only start with a letter (or a "." followed by a non-number), so getSymbols() converts "^GSPC" to "GSPC".  
  
If the data are in a CSV file, you can still use the getSymbols() function, but it would look something like:  
getSymbols("GSPC", src="csv")  
This assumes there's a file named "GSPC.csv" in your current working directory (see functions getwd() and setwd()). getSymbols() has ways to deal with other file types as well...  
  
Since I'm using close-to-close returns, I'm assuming you transact on the close price. This is why I align the signals generated with today's data with tomorrow's returns. E.g. if today's data gives me a long signal, I'll buy at the close and hold until tomorrow's close. Great questions!  
  
There are missing values in my signals because the first two RSI(2) values are missing, and the lag creates another missing value. If I did not replace the missing values with zero, it would cause the result of the cumprod() function to be a vector of missing values (a missing value added, subtracted, multiplied, or divided by anything produces a missing value).  
  
I did not show the chart created by:  
chartSeries(GSPC, type="line")  
I was hoping you would see it when you copy/paste the code into your own R session. :) And yes, it compares the strategy results with the S&P.  
  
Future posts will show how to work with a basket of stocks and multiple strategies. It's good to know that I've planned to address something of interest.  
  
I'm not sure what you mean about producing a scan of stocks as you go forward in time. Could you clarify?
<hr />
#### Sure - when you're running a complex system, you n...
[Damian](https://www.blogger.com/profile/16016686632386396090 "noreply@blogger.com") - <time datetime="2009-04-18T09:28:00.000-05:00">Apr 6, 2009</time>

Sure - when you're running a complex system, you need a way to scan the market on an ongoing basis to find opportunities. So, I want to scan EOD today for entries tomorrow. Make sense?
<hr />
#### A very interesting post and a great example of usi...
[Unknown](https://www.blogger.com/profile/14836951237109349355 "noreply@blogger.com") - <time datetime="2009-04-18T12:05:00.000-05:00">Apr 6, 2009</time>

A very interesting post and a great example of using R in the context of evaluating a trading strategy.  
  
When I first ran the code I got the error at the bottom of this post. However, if I lop of the first row of the signals vectors (e.g. with tail(sigup, -1)) I get the results you posted.  
  
I am very new to R; does this make sense to you?  
  
_Error in addTA(eq\_all) :  
non-xtsible data must match the length of the underlying series  
In addition: Warning messages:  
1: In ret \* sigup :  
longer object length is not a multiple of shorter object length  
2: In ret \* sigdn :  
longer object length is not a multiple of shorter object length  
3: In ret \* sig :  
longer object length is not a multiple of shorter object length_
<hr />
#### Damian, If I understand correctly, that should be...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-04-18T20:55:00.000-05:00">Apr 0, 2009</time>

Damian,  
  
If I understand correctly, that should be as easy as running the code I posted each day... but removing the "from=" argument from getSymbols() and looking at today's "sig" value. Does that answer your question?  
  
Toby,  
  
Thanks for the comment. My guess is that the error is caused by the Lag() function. I intended to use quantmod:::Lag(), but if you attached - via library() - another package with a Lag() function before you attached quantmod, the first package's Lag() function would be used. I will edit the code in the post to be more robust. Thank you!
<hr />
#### Josh, thanks for that - clears things up for me! A...
[Unknown](https://www.blogger.com/profile/14836951237109349355 "noreply@blogger.com") - <time datetime="2009-04-19T16:07:00.000-05:00">Apr 0, 2009</time>

Josh, thanks for that - clears things up for me! Again, a very useful example code. Thanks for posting.
<hr />
#### Josh, Thanks for your blog, and especially this p...
[JT](https://www.blogger.com/profile/12551175212607761356 "noreply@blogger.com") - <time datetime="2009-04-25T13:39:00.000-05:00">Apr 6, 2009</time>

Josh,  
  
Thanks for your blog, and especially this post. I eagerly await your followup.  
  
I've also been having some similar problems as Toby. Going back and working through it line by line, my first observation is that the length of rsi, and therefore sigup, sigdn and sig is 1 element longer than Cl(GSPC). This is partially what causes the warnings in the calculation of eq\_up, eq\_dn, and eq\_all. It's also what causes the failure of the addTA(eq\_all) line. At least, that's the best I can figure.  
  
I was wondering about the calculation of eq\_all, what is it supposed to represent? If it's supposed to represent the cumulative return from both the long and short strategy, should you be taking the absolute value of sig?  
  
Again, thanks so much for the post. It really helps to be able to learn from real examples.
<hr />
#### jt, You're welcome. I hope to post the follow-up...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2009-04-26T21:45:00.000-05:00">Apr 1, 2009</time>

jt,  
  
You're welcome. I hope to post the follow-up in a few days. I just got back from the R/Finance 2009 conference in Chicago (I will be posting about that as well).  
  
Please ensure you're using the latest versions of TTR and quantmod from CRAN and the code I updated to fix Toby's issue. Also, please double-check your results - because 'rsi' (with the arguments I used) and 'GSPC' should never have different lengths.  
  
You're correct, 'eq\_all' represents the strategy's total cumulative return. Taking the absolute value of 'sig' before calculating 'eq\_all' would convert all the short signals to long signals. Note that I multiplied by -1 when calculating 'eq\_dn' in order to make the equity curve trend downward like Michael's graph.
<hr />
#### Hello and thanks for sharing your work. I was loo...
[Intelligent Trading](https://www.blogger.com/profile/17765336450326139518 "noreply@blogger.com") - <time datetime="2010-03-01T23:01:20.203-06:00">Mar 2, 2010</time>

Hello and thanks for sharing your work. I was looking over this issue with flipping the short sales upsidown. It seems to me that using your methodology, shows that the short sales were net positive, in which case the total short return would be net pos. Have you contacted the original author to ask why his short return curve was net negative (It seems he intended that as his average short daily results shows a negative value)? It is very important to decide one way or the other as the results will be completely backwards and obviously only one method is the correct one.  
  
The following would seem to adjust all the values back to the way you intended.  
  
sigdn\[is.na(sigdn)\] <- -1  
eq\_dn <- cumprod(1+ret\*sigdn)  
  
plot.zoo( cbind(eq\_up, eq\_dn,eq\_all),  
ylab=c("Long","Short","Combined"), col=c("green","red","blue"),  
main="Simple RSI(2) Strategy: 2000-01-02 through 2008-12-07" )  
  
Also, the plot would be useful to show all three curves.  
  
Look forward to going through more of your blog.  
\-----------------------------------  
http://intelligenttradingtech.blogspot.com/
<hr />
#### Intelligent Trading, The short sales were flipped...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-03-06T18:53:59.495-06:00">Mar 0, 2010</time>

Intelligent Trading,  
  
The short sales were flipped only to replicate the chart. Notice the eq\_all object does not use the flipped short sales. Thanks for the code to plot all thee series.
<hr />
#### Hi Josh, I am getting the following errors when ...
[Unknown](https://www.blogger.com/profile/14317888627251050785 "noreply@blogger.com") - <time datetime="2010-11-08T09:24:22.866-06:00">Nov 1, 2010</time>

Hi Josh,  
  
I am getting the following errors when running the code.  
I have uploaded the data from a CSV file, and when I plot the chart "Michael's nice chart" the dates do not show in the chart, instead I get a series running from 0 to 3000.  
Also if I try to add the total equity line, I get the following error message  
  
"Error en addTA(eq\_all) :  
non-xtsible data must match the length of the underlying series"  
  
Do you know where the error comes from and how I could fix it?  
  
Thank you very much
<hr />
#### Hi Javier, Since I don't have access to your ...
[Joshua Ulrich](https://www.blogger.com/profile/16641971932645230429 "noreply@blogger.com") - <time datetime="2010-11-09T21:54:05.575-06:00">Nov 3, 2010</time>

Hi Javier,  
  
Since I don't have access to your data, I can only guess what the problem(s) may be. My guess is that you didn't read your CSV into R as an xts object. read.csv() creates a data.frame. From there, you need to create an xts object, or at least ensure that the rownames of your data.frame contain the dates/times so as.xts can create an xts object.  
  
HTH,  
Josh
<hr />
#### Thanks, now its working fine.
[Unknown](https://www.blogger.com/profile/14317888627251050785 "noreply@blogger.com") - <time datetime="2010-11-18T04:59:35.482-06:00">Nov 4, 2010</time>

Thanks, now its working fine.
<hr />
