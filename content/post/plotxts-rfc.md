---
title: 'plot.xts RFC'
date: 2015-04-20T12:45:00.000-05:00
draft: false
aliases: [ "/2015/04/plotxts-rfc.html" ]
tags : [xts, Releases, R]
---

We have been working on a new charting engine for **xts::plot.xts** for the past couple years. It started with Michael Weylandt's work during the 2012 Google Summer of Code, and Ross Bennett took up the torch during the 2014 GSoC.  
  
This new engine improves the functionality, modularity, and flexibility of **plot.xts**by building off the framework Jeff Ryan began with **q****uantmod::chart\_Series**.  The modular framework allows users to plot an xts object and incrementally build custom charts by adding panels of new data (including transformations of the original xts object).  
  
The main objective was to provide functionality similar to **chartSeries** and **addTA** for xts objects. The current code includes support for:  

*   Basic time series plots with sensible defaults
*   Plotting xts objects by column "automagically" as separate panels
*   Small multiples with multiple pages
*   "Layout-safe" so multiple specifications/panels can be charted in a single device
*   Easily add data to an existing plot or add panels similar to **quantmod::add\***
*   Event lines

The xts team would greatly appreciate any comments, feedback, and bug reports before the upcoming CRAN release at the end of April.  
  
The new version of **plot.xts** is in the main xts development code base, which is available on GitHub in the [develop branch](https://github.com/joshuaulrich/xts).  GitHub is also the place to submit [b](https://github.com/joshuaulrich/xts/issues)[ug reports and feature requests](https://github.com/joshuaulrich/xts/issues).  
  
Note that the new **plot.xts** includes breaking changes to the original (and rather limited) **plot.xts**.  However, we believe the new functionality more than compensates for the potential one-time inconvenience.