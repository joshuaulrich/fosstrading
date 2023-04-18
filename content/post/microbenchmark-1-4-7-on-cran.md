---
title: 'microbenchmark_1.4-7 on CRAN'
date: 2019-10-10T06:21:00.000-05:00
draft: false
aliases: [ "/2019/10/microbenchmark14-7-on-cran.html" ]
tags : [Releases, R]
---

I pushed an updated [microbenchmark to CRAN](https://cran.r-project.org/package=microbenchmark) a couple weeks ago. There were two noteworthy changes, thanks to great contributions from [@MichaelChirico](https://github.com/MichaelChirico) and [@harvey131](https://github.com/harvey131).  

<!--more-->

Michael fixed a bug in the check for whether the unit argument was a character string ([#9](https://github.com/joshuaulrich/microbenchmark/issues/9), [#10](https://github.com/joshuaulrich/microbenchmark/pull/10)). The prior behavior was an uninformative error.  
  
Harvey added a feature to allow you to use a string for common checks: "equal", "identical", and "equivalent" ([#16](https://github.com/joshuaulrich/microbenchmark/pull/16)). So you don't need to create a custom function to use `all.equal()`, `all.equal(..., check.attributes = FALSE)`, and identical, respectively.  
  
I also converted the unit tests to use [RUnit](https://cran.r-project.org/package=RUnit). I also made some changes to the repo, including adding a contributing guide and issue/pull-request templates.

{{< post-footer id="post-footer.html" >}}
