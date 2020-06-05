---
title: 'Introduction to PortfolioAnalytics'
date: 2014-03-29T12:25:00.002-05:00
draft: false
aliases: [ "/2014/03/intro-to-portfolioanalytics.html" ]
tags : [Examples, PortfolioAnalytics, Code, R]
---

This is a guest post by Ross Bennett. Ross is currently enrolled in the University of Washington Master of Science in Computational Finance & Risk Management program with an expected graduation date of December 2014. He worked on the PortfolioAnalytics package as part of the Google Summer of Code 2013 project and continues to work on the package as a Research Assistant at the University of Washington.

His work on the package focused on implementing a portfolio specification to separate and modularize assets, constraints, and objectives. Support for additional constraints including group, diversification, and factor exposure constraints was also added. The random portfolio solver was expanded to include two additional methods of generating random portfolios. The optimization backends were further standardized for sets of constraints and objectives that can be solved via linear and quadratic programming solvers using the ROI package. Charts including risk budget and efficient frontiers were added as well as standardizing the charting across all optimization engines.

This post is meant to provide a very basic introduction to the PortfolioAnalytics package. PortfolioAnalytics is an R package designed to provide numerical solutions and visualizations for portfolio problems with complex constraints and objectives. A key feature of PortfolioAnalytics is the ability to specify a portfolio with assets, constraints, and objectives that is solver agnostic, where the objective can be comprised of any valid R function. PortfolioAnalytics utilizes multiple solvers as backends for the optimization; linear programming, quadratic programming, differential evolution, random portfolios, particle swarm, and generalized simulated annealing. For optimization problems that can be formulated as linear or quadratic problems, these can be solved very fast and efficiently using the appropriate linear or quadratic solver supported by PortfolioAnalytics. For optimization problems with more complex constraints and objectives, a global solver such as differential evolution or random portfolios can be used to find a solution.

Ross will be giving a tutorial on PortfolioAnalytics at the [R/Finance 2014 Conference](http://www.rinfinance.com). The tutorial will cover the key features of PortfolioAnalytics along with several comprehensive examples. Those who want to learn more about how R is used in finance are encouraged to attend.

The primary functions in PortfolioAnalytics to specify a portfolio with constraints and objectives are `portfolio.spec`, `add.constraint`, and `add.objective`.

```
library(PortfolioAnalytics)  
data(edhec)  
returns <- edhec[, 1:6]  
funds <- colnames(returns)  
```

Here we create a portfolio object with `portfolio.spec`. The `assets` argument is a required argument to the `portfolio.spec` function. `assets` can be a character vector with the names of the assets, a named numeric vector, or a scalar value specifying the number of assets. If a character vector or scalar value is passed in for `assets`, equal weights will be created for the initial portfolio weights.

```
init.portfolio <- portfolio.spec(assets = funds)  
```

The `portfolio` object is an S3 class that contains portfolio level data as well as the constraints and objectives for the optimization problem. You can see that the constraints and objectives lists are currently empty, but we will add sets of constraints and objectives with `add.constraint` and `add.objective`.

```
print.default(init.portfolio)  
```

```
## $assets  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.1667                0.1667                0.1667   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.1667                0.1667                0.1667   
##   
## $category_labels  
## NULL  
##   
## $weight_seq  
## NULL  
##   
## $constraints  
## list()  
##   
## $objectives  
## list()  
##   
## $call  
## portfolio.spec(assets = funds)  
##   
## attr(,"class")  
## [1] "portfolio.spec" "portfolio"  
```

Here we add the full investment constraint. The full investment constraint is a special case of the leverage constraint that specifies the weights must sum to 1 and is specified with the alias `type="full_investment"` as shown below.

```
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "full_investment")  
```

Now we add box constraint to specify a long only portfolio. The long only constraint is a special case of a box constraint where the lower bound of the weights of each asset is equal to 0 and the upper bound of the weights of each asset is equal to 1. This is specified with `type="long_only"` as shown below. The box constraint also allows for per asset weights to be specified.

```
init.portfolio <- add.constraint(portfolio = init.portfolio, type = "long_only")  
```

The following constraint types are supported:  

*   leverage
*   box
*   group
*   position\_limit1
*   turnover2
*   diversification
*   return
*   factor\_exposure
*   transaction\_cost2

1.  Not supported for problems formulated as quadratic programming problems solved with `optimize_method="ROI"`.
2.  Not supported for problems formulated as linear programming problems solved with `optimize_method="ROI"`.

Below we create two new portfolio objects. Note that we areassigning new names for the portfolios. This re-uses the constraints from `init.portfolio` and adds the objectives specified below to `minSD.portfolio` and `meanES.portfolio` while leaving `init.portfolio` unchanged. This is useful for testing multiple portfolios with different objectives using the same constraints because the constraints only need to be specified once and several new portfolios can be created using an initial portfolio object.

```
# Add objective for portfolio to minimize portfolio standard deviation  
minSD.portfolio <- add.objective(portfolio=init.portfolio,   
                                 type="risk",   
                                 name="StdDev")  
  
# Add objectives for portfolio to maximize mean per unit ES  
meanES.portfolio <- add.objective(portfolio=init.portfolio,   
                                  type="return",   
                                  name="mean")  
  
meanES.portfolio <- add.objective(portfolio=meanES.portfolio,   
                                  type="risk",   
                                  name="ES")  
```

Note that the `name` argument in `add.objective` can be any valid R function. Several functions are provided in the PerformanceAnalytics package that can be specified as the `name` argument such as ES/ETL/CVaR, StdDev, etc.

The following objective types are supported:  

*   return
*   risk
*   risk\_budget
*   weight\_concentration

As demonstrated above, the `add.constraint` and `add.objective` functions were designed to be very flexible and modular so that constraints and objectives can easily be specified and added to `portfolio` objects.

PortfolioAnalytics provides a `print` method so that we can easily view the assets, constraints, and objectives that we have specified for the portfolio.

```
print(minSD.portfolio)  
```

```
## **************************************************  
## PortfolioAnalytics Portfolio Specification   
## **************************************************  
##   
## Call:  
## portfolio.spec(assets = funds)  
##   
## Assets  
## Number of assets: 6   
##   
## Asset Names  
## [1] "Convertible Arbitrage" "CTA Global"            "Distressed Securities"  
## [4] "Emerging Markets"      "Equity Market Neutral" "Event Driven"           
##   
## Constraints  
## Number of constraints: 2   
## Number of enabled constraints: 2   
## Enabled constraint types  
##      - full_investment   
##      - long_only   
## Number of disabled constraints: 0   
##   
## Objectives  
## Number of objectives: 1   
## Number of enabled objectives: 1   
## Enabled objective names  
##      - StdDev   
## Number of disabled objectives: 0  
```

```
print(meanES.portfolio)  
```

```
## **************************************************  
## PortfolioAnalytics Portfolio Specification   
## **************************************************  
##   
## Call:  
## portfolio.spec(assets = funds)  
##   
## Assets  
## Number of assets: 6   
##   
## Asset Names  
## [1] "Convertible Arbitrage" "CTA Global"            "Distressed Securities"  
## [4] "Emerging Markets"      "Equity Market Neutral" "Event Driven"           
##   
## Constraints  
## Number of constraints: 2   
## Number of enabled constraints: 2   
## Enabled constraint types  
##      - full_investment   
##      - long_only   
## Number of disabled constraints: 0   
##   
## Objectives  
## Number of objectives: 2   
## Number of enabled objectives: 2   
## Enabled objective names  
##      - mean   
##      - ES   
## Number of disabled objectives: 0  
```

Now that we have portfolios set up with the desired constraints and objectives, we use `optimize.portfolio` to run the optimizations. The examples below use `optimize_method="ROI"`, but several other solvers are supported including the following:

*   DEoptim (differential evolution)
*   random portfolios
    *   sample
    *   simplex
    *   grid
*   GenSA (generalized simulated annealing)
*   pso (particle swarm optimization)
*   ROI (R Optimization Infrastructure)
    *   Rglpk
    *   quadprog

The objective to minimize standard deviation can be formulated as a quadratic programming problem and can be solved quickly with `optimize_method="ROI"`.

```
# Run the optimization for the minimum standard deviation portfolio  
minSD.opt <- optimize.portfolio(R = returns, portfolio = minSD.portfolio,   
    optimize_method = "ROI", trace = TRUE)  
  
print(minSD.opt)  
```

```
## ***********************************  
## PortfolioAnalytics Optimization  
## ***********************************  
##   
## Call:  
## optimize.portfolio(R = returns, portfolio = minSD.portfolio,   
##     optimize_method = "ROI", trace = TRUE)  
##   
## Optimal Weights:  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.0000                0.0652                0.0000   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.0000                0.9348                0.0000   
##   
## Objective Measure:  
##   StdDev   
## 0.008855  
```

The objective to maximize mean return per ES can be formulated as a linear programming problem and can be solved quickly with `optimize_method="ROI"`.

```
# Run the optimization for the maximize mean per unit ES  
meanES.opt <- optimize.portfolio(R = returns, portfolio = meanES.portfolio,   
    optimize_method = "ROI", trace = TRUE)  
  
print(meanES.opt)  
```

```
## ***********************************  
## PortfolioAnalytics Optimization  
## ***********************************  
##   
## Call:  
## optimize.portfolio(R = returns, portfolio = meanES.portfolio,   
##     optimize_method = "ROI", trace = TRUE)  
##   
## Optimal Weights:  
## Convertible Arbitrage            CTA Global Distressed Securities   
##                0.0000                0.2940                0.2509   
##      Emerging Markets Equity Market Neutral          Event Driven   
##                0.0000                0.4552                0.0000   
##   
## Objective Measure:  
##     mean   
## 0.006635   
##   
##   
##      ES   
## 0.01837  
```

The PortfolioAnalytics package provides functions for charting to better understand the optimization problem through visualization. The `plot` function produces a plot of of the optimal weights and the optimal portfolio in risk-return space. The optimal weights and chart in risk-return space can be plotted separately with `chart.Weights` and `chart.RiskReward`.

```
plot(minSD.opt, risk.col="StdDev", chart.assets=TRUE,   
     main="Min SD Optimization",  
     ylim=c(0, 0.0083), xlim=c(0, 0.06))  
```

[![](http://4.bp.blogspot.com/-bLrvc7w1wJ8/Uy99ONrSmeI/AAAAAAAAANU/08dJ2PN9-eY/s400/unnamed-chunk-102.png)](http://4.bp.blogspot.com/-bLrvc7w1wJ8/Uy99ONrSmeI/AAAAAAAAANU/08dJ2PN9-eY/s1600/unnamed-chunk-102.png)

```
plot(meanES.opt, chart.assets=TRUE,   
     main="Mean ES Optimization",  
     ylim=c(0, 0.0083), xlim=c(0, 0.16))  
```

[![](http://3.bp.blogspot.com/-2RRkbXaQy0s/Uy99i2-Q2LI/AAAAAAAAANc/6eRenUhx-X8/s400/unnamed-chunk-101.png)](http://3.bp.blogspot.com/-2RRkbXaQy0s/Uy99i2-Q2LI/AAAAAAAAANc/6eRenUhx-X8/s1600/unnamed-chunk-101.png)

This post demonstrates how to construct a portfolio object, add constraints, and add objectives for two simple optimization problems; one to minimize portfolio standard devation and another to maximize mean return per unit expected shortfall. We then run optimizations on both portfolio objects and plot the results of each portfolio optimization. Although this post demonstrates fairly simple constraints and objectives, PortfolioAnalytics supports complex constraints and objectives as well as many other features that will be covered in subsequent posts.

The PortfolioAnalytics package is part of the [ReturnAnalytics](http://r-forge.r-project.org/projects/returnanalytics/) project on R-Forge. For additional examples and information, refer to the several vignettes and demos are provided in the package.
