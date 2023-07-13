---
title: 'DataCamp course: Importing and managing financial data'
date: 2016-06-17T11:32:00.000-05:00
draft: false
aliases: [ "/2016/06/importing-and-managing-financial-data.html" ]
categories: [ Articles ]
tags : [quantmod, R]
---

The team at [DataCamp](https://www.datacamp.com/) announced a new R/Finance course series in a recent email:  

> Subject: Data Mining Tutorial, R/Finance course series, and more!  
>   
> **R/Finance - A new course series in the works**  
> We are working on a whole new course series on applied finance using R. This new series will cover topics such as time series (David S. Matteson), portfolio analysis (Kris Boudt), the xts and zoo packages (Jeffrey Ryan), and much more. Start our first course [Intro to Credit Risk Modeling in R](https://www.datacamp.com/courses/introduction-to-credit-risk-modeling-in-r) today.

I'm excited to announce that I'm working on a course for this new series! It will provide an introduction to importing and managing financial data.  
  
If you've ever done anything with financial or economic time series, you know the data come in various shapes, sizes, and periodicities. Getting the data into R can be stressful and time-consuming, especially when you need to merge data from several different sources into one data set. This course will cover importing data from local files as well as from internet sources.  
  
The tentative course outline is below. I'd really appreciate your feedback on what should be included in this introductory course! So let me know if I've omitted something, or if you think any of the topics are too advanced.  
  
Introduction to importing and managing financial data  

1.  Introduction and downloading data

1.  getSymbols design overview, Quandl
2.  Finding and downloading data from internet sources

1.  E.g. getSymbols.yahoo, getSymbols.FRED, Quandl

4.  Loading and transforming multiple instruments
5.  Checking for errors (i.e. summary stats, visualizing)

3.  Managing data from multiple sources

1.  Setting per-instrument sources and default arguments

1.  setSymbolLookup, saveSymbolLookup, loadSymbolLookup, setDefaults

3.  Handling instruments names that clash or are not valid R object names

5.  Aligning data with different periodicities

1.  Making irregular data regular
2.  Aggregating to lowest frequency
3.  Combining monthly with daily
4.  Combining daily with intraday

7.  Storing and updating data

1.  Creating an initial RData-backed storage
2.  Adjusting financial time-series
3.  Handling errors during update process
