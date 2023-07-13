---
title: 'getSymbols Rebooted'
date: 2023-05-22T10:14:00.000-05:00
draft: false
aliases: [ "/2023/05/getsymbols-rebooted.html" ]
categories: [ Articles ]
tags : [quantmod, R]
---

quantmod and `getSymbols()` have been a core part of the R/Finance ecosystem for over 15 years. We want to change some things, but they would break existing code. We can make these changes in the new ['rfimport'](https://github.com/joshuaulrich/rfimport/) package instead.

<!--more-->

### Background

The quantmod package has been a core part of the R/Finance ecosystem for over 15 years. It's awesome that the package is so popular, but that also comes with responsibility to maintain backward compatibility. Breaking changes may break code used for making business decisions, research, production, blog posts, books, courses, answers on [stackoverflow](https://stackoverflow.com), and much more. We take this responsibility seriously, and do our best to keep functions backward compatible. Sometimes breaking changes are necessary (e.g. bug fixes, changes to external data sources, etc.), but we do our best to make them carefully, with plenty of warning and lead time for users to adjust their code.

### Motivation

There are things in quantmod that we want to change, but they would certainly break existing code. No matter how much we'd like to make those changes, we can't justify breaking a large portion of the code our community has written in the past 15+ years.

We can create a new package instead of making these changes in quantmod. ['rfimport'](https://github.com/joshuaulrich/rfimport/) is where we will work on new implementations that improve on the pieces in `getSymbols()` that we would like to change. This code is *extremely alpha*. This is the time to provide feedback, suggestions, feature requests, etc. Know that we will break things, maybe without warning. You should consider the API unstable until the 1.0.0 release.

### Refresher on how `getSymbols()` works

By default `getSymbols()` creates objects in the environment it's called from, and it returns the value of the `Symbols` argument. It's good practice for functions to avoid changing anything in the user's environment (this is called having side-effects). It's better for functions to only return a value, like `getSymbols(..., auto.assign = FALSE)` does. `getSymbols()` does not support `auto.assign = FALSE` for more than one symbol.

`getSymbols()` also uses functionality that was formerly provided by the archived ['Defaults'](https://cran.r-project.org/package=Defaults) package. This functionality allows users to set default values for `getSymbols()` source method arguments (e.g. `return.class = "data.frame"`). This is also a side-effect because it makes `getSymbols()` depend on something other than argument values.

`getSymbols()` specifies the data sources via its `src` argument, and uses the `src` argument to determine which source method to use (e.g. `getSymbols("SPY", src = "yahoo")` will call `getSymbols.yahoo("SPY")` behind the scenes). This is essentially method dispatch, but done manually rather than using R's built-in S3 functionality.

# What we've learned

1. We should avoid the side-effect of creating objects in the calling environment.
1. Data sources should use S3 method dispatch, and documentation needs to be easier to find.
1. Stock ticker symbology is a pain and we need a better way to handle it.
1. We need a way to provide functionality like the ['Defaults'](https://cran.r-project.org/package=Defaults) package did, but without side-effects.

### 1. Automatically creating objects

`getSymbols()` creates an object for every value in the `Symbols` argument. This isn't an issue for a few symbols, but it clutters the environment when there are several hundred symbols. You can load all the symbols into a separate environment, but that's not a pattern most users are familiar with.

We wanted to remove the ability to load objects into the calling environment, and even created a warning about changing `auto.assign = FALSE` as the default for `getSymbols()` and recommending users replace their `getSymbols()` call with the `loadSymbols()` function that already exists. But we ultimately decided breaking the community's code wasn't worth it.

Automatically creating objects makes it cumbersome to put prices for all symbols into one object. This is a common use case and there are several steps. It should be possible with one or two function calls. Here's an example.

```r
symbols <- c("SPY", "AAPL")
getSymbols(symbols)

# Put all the prices into one xts object,
prices <- do.call(merge, lapply(symbols, get))
# or
prices <- do.call(merge, mget(symbols))

# Extract only the Close prices
close_prices <- Cl(prices)

# Remove ".Close" suffix so close_prices[, "SPY"] works
colnames(close_prices) <- sub(".Close", "", colnames(close_prices))
```

Automatically creating objects also makes passing all the data to another function awkward. It causes users to do things like:

* Call `getSymbols()` in any function that needs data, which may mean the same data is imported multiple times.
* Pass the same `symbols` object to `getSymbols()` and the other function. Then the other function searches through environments to find the objects with named with those `symbols`.
* Users could put all the data in an environment and use that as an argument to the function, but I haven't seen many people use this pattern.

### 2. Data source methods

Different `getSymbols()` source methods can (or may need to) have different arguments. Ideally the source methods wouldn't be exported because users shouldn't call them directly (users should call `getSymbols("SPY", src = "yahoo")` instead of `getSymbols.yahoo("SPY")`). It's hard to find documentation for unexported functions, which means it's hard to know what arguments are available for each source method.

The source methods are named like S3 methods even though `getSymbols()` isn't a generic function and the source methods aren't actual S3 methods. This has the potential to create odd behavior that would confuse users.

### 3. Ticker symbology

There are two major issues with ticker symbols.

1. Exchanges and data providers sometimes use different ticker symbols for the same security.
1. Some ticker symbols are not valid R object names.

Another issue is when the ticker symbol is similar to the name of one of the price columns. This has come up several times with Lowe's (LOW). The `Lo()` and `OHLC()` functions think all of the columns with the ticker symbol in the column name are the low price for the period.

#### Same security, different ticker

This isn't `getSymbols()`'s fault and it's out of our control, but it could be handled better. Exchange and data source symbology is awful. Identifiers for the same series are often different across exchanges and data providers. For example: the symbol for Berkshire Hathaway B-class shares is "BRK-B" for Yahoo Finance, "BRK/B" for the SIP (Securities Information Processor), "BRK B" for ICE, and probably "BRK.B" somewhere else.

This is a difficult problem and will likely take a lot of effort to get right. Therefore it won't be a high priority initially.

#### Invalid R object names

`getSymbols()` tries to create objects with valid R names, but only does so for *some* symbols that aren't valid R object names. For example, `BRK-B`, `BRK B`, and `BRK/B` aren't valid R objects names because valid names start with a letter or a dot (`.`), and can only contain letters, numbers, a dot, or an underscore.

Here are some common examples of ticker symbology woes:

`^DJI` isn't a valid R object name because it starts with `^`. So `getSymbols()` creates an object with the `^` removed. But then you can't use the code below to put all the prices into one object. Also notice that `getSymbols()` *returns* `"^DJI"` even though it creates an object with a different name.

```r
symbols <- c("^DJI", "BRK-B")
getSymbols(symbols)
## [1] "^DJI" "BRK-B"

prices <- do.call(merge, mget(symbols))
## Error: value for '^DJI' not found
```

You have to remove the leading `^` manually. And you have to set `fixed = TRUE` in the call to `sub()` because `^` is a special character in regular expressions. *Sigh*.

```r
prices <- do.call(merge, mget(sub("^", "", symbols, fixed = TRUE)))
```

Recall that `BRK-B` also isn't a valid R name because of the `-`. But it wasn't an issue in the code above because `getSymbols()` made an object named `BRK-B`, not an object with a valid R name. This is confusing for users because they can't easily access that object (i.e. `head(BRK-B)` is an error). This is a pervasive issue for several foreign exchanges with tickers that begin with numbers (e.g. `000001.SZ`).

Another issue with symbols that aren't valid R object names is that many R functions will convert column names into valid R object names, including `merge.xts()`. So you can't use the input symbol to subset the resulting xts object. Here's an example:

```r
# Extract the close prices and remove ".Close" suffix
close_prices <- Cl(prices)
colnames(close_prices) <- sub(".Close", "", colnames(close_prices))

# Extract the close price for "BRK-B"
close_prices[, "BRK-B"]
## Error in `[.xts`(close_prices, , "BRK-B") : subscript out of bounds
colnames(close_prices)
## [1] "DJI"   "BRK.B"
```

`setSymbolLookup()` exists to help with things like this, but it's another function users have to learn to use and my experience is that most users don't know about `setSymbolLookup()`. I just had to look at the source to figure out how to use it to make `getSymbols()` return a valid R object for `"BRK-B"`.

```r
setSymbolLookup(BRK.B = list(name = "BRK-B", src = "yahoo"))
```

If I have to look at the source code to figure out how to do this, users don't have a chance. You may think, "but you could document how to do this", but writing documentation isn't fun. And who reads the documentation anyway? ;-)

### 4. 'Defaults' functionality

The 'Defaults' functionality in quantmod comes from the archived ['Defaults'](https://cran.r-project.org/package=Defaults) package. This functionality allows users to set new default argument values to any `getSymbols()` source function. This is helpful because it makes importing easier. But it means `getSymbols()` relies on something other than its parameter values, and it's good practice to avoid side-effects like this.

This gave users the ability to set preferences like return class, periodicity (e.g. hourly, daily, monthly), connection settings (e.g. credentials, API keys).

# 'rfimport' design and features

The design of ['rfimport'](https://github.com/joshuaulrich/rfimport/) is influenced by the [`DBI`](https://cran.r-project.org/web/packages/DBI/index.html) package, which provides a set of generic 'database interface' functions. Users create connection objects by creating a 'driver' object for the specific database and passing that to `dbConnect()`. Then you pass that connection object to the other `DBI` functions. For example, to query an execute a statement for a PostgreSQL database:

```r
library(RPostgreSQL)

driver <- PostgreSQL()
conn <- DBI::dbConnect(driver)
student_count <- DBI::dbGetQuery(conn, "select count(*) from students")
```

The ['rfimport'](https://github.com/joshuaulrich/rfimport/) `sym_yahoo()` function corresponds to the `PostgreSQL()` function in the example above. And the `import_ohlc()` function pulls the data like `DBI::dbGetQuery()`. For example:

```r
library(rfimport)

# The sym_* functions are a combination of the
# driver, connection, and query in DBI
syms <- sym_yahoo("SPY")

# Import some data from Yahoo Finance
spy <- import_ohlc(syms)
```

### Symbol specification

The package introduces a new virtual S3 class `"symbol_spec"` as the basis for creating sub-classes that hold all necessary information to connect to a data source. This virtual class allows users to combine symbols from different data sources into a single vector. For example: `import_collection(c(sym_yahoo("SPY"), sym_tiingo("DIA")))` will import data for "SPY" from [Yahoo Finance](https://finance.yahoo.com/) and data for "DIA" from [Tiingo](https://www.tiingo.com/).

Each data source will have its own `symbol_spec` constructor. The constructor will have an argument for the vector of symbols and other arguments for all the other data source connection settings. It will return an object that inherits from the new virtual `symbol_spec` For example `sym_yahoo()` will return a `c("yahoo", "symbol_spec")` class vector.

The help page for the symbol spec constructors can also document the import methods that the data source supports. So `help("sym_yahoo")` would also contain information about `import_ohlc.yahoo()` and `import_collection.yahoo()`. That way, users don't need to know the name of the data source method in order to find its documentation.

### Ticker symbology

The package would standardize how index tickers are specified. One possibility is to prefix the ticker with an `i` or `i_` (e.g. `iDJI` or `i_DJI`).

It would also standardize how to specify share classes, warrants, preferred, etc. One possibility is to use an underscore to identify share classes, a lowercase 'w' for warrants, and a lowercase 'p' for preferred. For example, `BRK_B` for Berkshire Hathaway B shares, `FOOw` for warrants, `BARp` for preferred. We could also include a translation table and/or function. This would take a lot of effort to do correctly.

An easier alternative would be creating a way to map source symbols to user-defined values. It makes the most sense to do this is the `sym_<source>()` constructor. But how should the mapping be specified? Some possibilities:

* `sym_yahoo(BRK.B = list(symbol = "BRK-B"))`
* `sym_yahoo(c(BRK.B = "BRK-B", "DIA"))`
* `sym_yahoo(c("BRK.B", "DIA"), sym_db = list(BRK.B = "BRK-B"))`

### Generic import functions

The package will have generic functions `import_ohlc()` and `import_collection()` to dispatch on `symbol_spec` sub-classes. `import_ohlc()` only handles a single symbol and returns one xts object. `import_collection()` will return a list of xts objects for one or more symbols.

Other generic import functions may be added in the future. It may make sense to include generic `import` functions that return specific types of data. For example: `import_ohlc()` for open, high, low, close, (adjusted, volume), and `import_bbo()` for best bid and offer.

The generics will have a `symbol_spec`, `dates`, `periodicity`, and `...` arguments.

`dates` can be either an ISO 8601 date interval (e.g. `dates = "2021-01-01/2021-12-31"`) or a two-element vector with the start and end dates (e.g. `dates = c("2021-01-01", "2021-12-31")`). The vector can be Date, POSIXct, or a character that is coercible to one of those two classes.

For example:

```r
# one symbol returned as an xts object
spy <- import_ohlc(sym_yahoo("SPY"), dates = "2021/2022")

# two symbols returned as a list of xts objects
stocks <- sym_tiingo(c("AAPL", "NFLX")) |>
    import_collection(dates = "2021-03-01/2022-11-31")
```

The `periodicity` argument specifies the interval between data points (e.g. daily, monthly, 15-minute). The data source determines the possible periodicity values, so the data source method is responsible for ensuring the requested periodicity value is available from the data source. ['rfimport'](https://github.com/joshuaulrich/rfimport/) will provide a standard way to specify the periodicity values. Then the source methods can translate those values into the value source needs. For example, one data source may use "monthly" for monthly data and another may use "months". Users would set `periodicity = "months"` for either source and the source method would translate the value to "monthly".

### Data source methods

Each data source will have a S3 method for the relevant import generics, rather than a `src` argument like `getSymbols()`. Calling `import_ohlc(sym_yahoo("SPY"))` will call the corresponding `import_ohlc.yahoo()` method to import data from [Yahoo Finance](https://finance.yahoo.com). `import_ohlc(sym_tiingo("DIA"))` will call `import_ohlc.tiingo()` to import data from [Tiingo](https://api.tiingo.com/).

#### Returned data

The built-in data source methods will automatically include dividends and splits (when available) for daily OHLCV data. They will be included as attributes on the returned OHLCV object. This will allow users to switch between adjusted and unadjusted prices without having to re-download the data.

The built-in data sources methods also will not include the series symbol in the OHLCV column names like `getSymbols()` currently does. It may make sense to include an attribute with the "source symbol" and the "R symbol" on the returned xts object (e.g. `src_symbol = "^DJI"` and `r_symbol = "iDJI")`. Then that attribute can be used later as part of the column names.

### Providing 'Defaults' functionality

Though we want to avoid side-effects, we probably want to provide a way to set credentials so they do not have to be provided for every import call.

We could provide this functionality in a pure way by creating an `options` object that holds a list of values. Users would create this object once and pass it to the relevant ['rfimport'](https://github.com/joshuaulrich/rfimport/) function (either `sym_<source>()` or `import_ohlc()`). The default options could be created by a function like `sym_<source>_options()`. This would be similar to the 'control' arguments to many optimization routines (e.g. `DEoptim.control()`).

# Open questions and considerations

### How should we specify the class of the returned object?

* Set it via a `return_class` argument in the `symbol_spec` constructor
    * PRO: each source is likely to have a specific data structure, and it wouldn't require creating a generic `import` function for each return type.
    * CON: allows the potential for one call to an `import_*_collection()` function to return a list of heterogeneous objects.

* Set it via a `return_class` argument in the `import` method
    * PRO: the method would return a list of objects that are all the same class.
    * CON: the generic and/or the default `import` method would need a `return_class` argument.

* Create a new generic `import` functions for each return class
    * PRO: makes it clear what the `import` function returns.
    * CON: namespace clutter, don't want generics for *every* class. Possibly provide generics for most widely used non-xts classes: data.frame, data.table, tibble, tsibble.

* The symbol specification can store a function that controls what data is returned. This doesn't seem appealing because it adds complexity and the user could call that function after the data is returned. For example: `sym_yahoo("SPY", return_func = as.data.table)`.

### How can we make it easier to manipulate results?

The most common use case is making a wide xts object with close prices from a list of xts objects. This currently requires several steps that are likely unfamiliar to most users. It should be possible with one or two function calls. We can consider Garrett See's [qmao](https://github.com/gsee/qmao) package for inspiration. For example, use 'price frames' to replace `do.call(merge, list_of_xts_objects)`.

There are lots of other common manipulations, like aggregating to a higher periodicity or applying a function to many symbols' data. The import functions will return something list-like, so users can use `lapply()` to apply any other function to each series.

# I need your help!

I don't want to do this in a vacuum. Please try the new package, provide feedback, suggestions, feature requests, and help clarify documentation.

I need to know how you're using `getSymbols()` and how you would use the new package. I'm not omniscient, so your feedback will be extremely valuable!

{{< post-footer id="post-footer.html" >}}
