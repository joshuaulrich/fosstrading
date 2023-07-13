---
title: 'Book Review: Parallel R'
date: 2012-06-05T10:31:00.000-05:00
draft: false
aliases: [ "/2012/06/book-review-parallel-r.html" ]
categories: [ Articles ]
tags : [Reviews, R]
---

[![](http://ws.assoc-amazon.com/widgets/q?_encoding=UTF8&Format=_SL160_&ASIN=1449309925&MarketPlace=US&ID=AsinImage&WS=1&tag=fotr09-20&ServiceVersion=20070822)](http://www.amazon.com/gp/product/1449309925/ref=as_li_ss_il?ie=UTF8&tag=fotr09-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1449309925)You have a problem: [R](http://www.r-project.org/) is single-threaded, but your code would be faster if it could simultaneously run on more than one core.  You have access to a cluster and/or your computer has multiple cores.  [Parallel R](http://www.amazon.com/gp/product/1449309925/ref=as_li_ss_tl?ie=UTF8&tag=fosstrading-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=1449309925), by Q. Ethan McCallum and Stephen Weston, can help you put this extra computing power to use.  
  
The book describes 6 approaches to distributed computing.  Thoughts on each approach follow:  
  
1) [snow](http://cran.r-project.org/web/packages/snow/)  

> The chapter starts by showing you how to create a socket cluster on a single machine (later sections discuss [MPI](http://www.open-mpi.org/) clusters, and socket clusters of several machines).Then a section describes how to initialize workers, with a later section giving a slightly advanced discussion on how functions are serialized to workers.  
>   
> There's a great demonstration (including graphs) of why/when you should use `clusterApplyLB()` instead of `clusterApply()`.  There's also a fantastic discussion on potential I/O issues (probably one of the most surprising/confusing issues to people new to distributed computing) and how `parApply()` handles them.  Then the authors provide a very useful `parApplyLB()` function.  
>   
> There are a few (but very important!) paragraphs on random number generation using the [rsprng](http://cran.r-project.org/web/packages/rsprng/index.html) and [rlecuyer](http://cran.r-project.org/web/packages/rlecuyer/index.html) packages.

2) [multicore](http://cran.r-project.org/web/packages/multicore/)  

> The chapter starts by noting that the multicore package only works on a single computer running a POSIX compliant operating system (i.e. most anything _except_ Windows).  
>   
> The next section describes the `mclapply()` function, and also explains how `mclapply()` creates a cluster each time it's called, why this isn't a speed issue, and how it is actually beneficial.  The next few sections describe some of the optional `mclapply()` arguments, and how you can achieve load balancing with `mclapply()`.  A good discussion of `pvec()`, parallel, and collect functions follow.  
>   
> There are some great tips on how to use the [rsprng](http://cran.r-project.org/web/packages/rsprng/index.html) and [rlecuyer](http://cran.r-project.org/web/packages/rlecuyer/index.html) packages for random number generation, even though they aren't directly supported by the multicore package.  The chapter concludes with a short, but effective, description of multicore's low-level API.

3) parallel (comes with R >= 2.14.0)  

> The chapter starts by noting that the parallel package is a combination of the snow and multicore packages.  This chapter is relatively short, since those two packages were covered in detail over the prior two chapters.  Most of the content discusses the implementation differences between parallel and snow/multicore.

4) R+[Hadoop](http://hadoop.apache.org/)  

> There's a full chapter primer on Hadoop and MapReduce, for those who aren't familiar with the software and concept.  The chapter ends with an introduction to Amazon's [EC2](http://aws.amazon.com/ec2/) and [EMR](http://aws.amazon.com/elasticmapreduce/) services, which significantly lower the barrier to using Hadoop.  
>   
> The chapter on R+Hadoop is very little R and mostly Hadoop.  This is because Hadoop requires more setup than the other approaches.  You will need to do some work on the command line and with environment variables.  
>   
> There are three examples; one Hadoop streaming and two using the Java API (which require writing/modifying some Java code).  The authors take care to describe each block of code in all the examples, so it's accessible to those who haven't written Java.

5) [RHIPE](http://www.rhipe.org/)  

> Using three examples, this chapter provides a thorough treatment of how to use RHIPE to abstract-away a lot of the boilerplate code required for Hadoop.  Everything is done in R.  As with the Hadoop chapter, the authors describe each block of code.  
>   
> RHIPE does require a little setup: it must be installed on your workstation and all cluster nodes.  In the examples, the authors describe how RHIPE allows you to transfer R objects between Map and Reduce phases, and they mention the RHIPE functions you can use to manipulate [HDFS](http://en.wikipedia.org/wiki/HDFS#Hadoop_Distributed_File_System) data.

6) [segue](http://code.google.com/p/segue/)  

> This is a very short chapter because the segue package has very narrow scope: using Amazon's EMR service in two lines of code!

Final thoughts:  
I would recommend this book to someone who is looking to move beyond the most basic distributed computing solutions.  The authors are careful to point you in the right direction and warn you of potential pitfalls of each approach.  
  
All but the most basic setups (e.g. a socket cluster on a single machine) will require some familiarity with the command line, environment variables, and networking.  This isn't the fault of the authors or any of the approaches... parallel computing just isn't that easy.  
  
I really expected to see something on using [foreach](http://cran.r-project.org/web/packages/foreach/), especially since Stephen Weston has done work on those packages.  It is mentioned briefly at the end of the book, so maybe it will appear in later editions.
