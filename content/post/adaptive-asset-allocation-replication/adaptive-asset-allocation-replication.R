## ----setup, include=FALSE, purl=TRUE------------------------------------------
suppressPackageStartupMessages({
    library(PerformanceAnalytics)
    library(quantmod)
    library(tseries)
    library(kableExtra)
    library(knitr)
    knitr::opts_chunk$set(
        eval = TRUE,
        echo = FALSE,
        fig.width = 7,
        fig.height = 6,
        fig.path = "",
        purl = TRUE
    )

    options(digits.secs = 6,
            xts_check_TZ = FALSE)
    Sys.setenv(TZ = "UTC")
})

checkUsage <- function(fun) {
    codetools::checkUsage(fun, all = TRUE, report = print)
}


## ----data, include=FALSE------------------------------------------------------
splice_returns <-
function(Ra, Rb)
{
    # fills NA values in Ra with values from Rb
    R <- merge(Ra, Rb, join = "left")
    is_na <- is.na(R[, 1])
    R[is_na, 1] <- R[is_na, 2]

    colnames(R) <- NULL
    return(R[,1])
}

import_spliced_returns <-
function(symbols, from = "1990-01-01")
{
    symbols <- symbols[1:2]

    data_env <- new.env()
    getSymbols(symbols, from = from, env = data_env, src = "tiingo")

    # combine into xts object
    prices <- do.call(merge, lapply(data_env, Ad))

    # clean up column names
    colnames(prices) <- sub(".Adjusted", "", colnames(prices), fixed = TRUE)

    # order columns
    prices <- prices[, symbols]

    # calculate returns
    returns <- Return.calculate(prices)

    result <- splice_returns(returns[,1], returns[,2])

    return(result)
}

# symbols
symbols <-
    c("VTI",  # US Stocks                  VTI   (2001-05), VITSX (1990-07), WFIVX (1999)
      "VGK",  # European Stocks            VGK   (2005-03), VEURX (1990-06),
      "EWJ",  # Japanese Stocks            EWJ   (1996-03), FJPNX (1992   )
      "EEM",  # Emerging Market Stocks     EEM   (2003-04), VEIEX (1994   )
      "VNQ",  # US Real Estate             VNQ   (2004-09), VGSIX (1996-05), (Wilshire indexes from FRED), ICF (2001-02)
      "RWX",  # International Real Estate  RWX   (2006-12), IERBX (1997-09), MSUAX (1997-11)
      "IEF",  # 7-10 Year Treasuries       IEF   (2002-07), LUTAX (1991, 7 WAL), PRTIX (1989 3-7 tho)
      "TLT",  # 20+ Year Treasuries        TLT   (2002-07), VUSTX (1986   ), PRULX (1989)
      "DBC",  # Commodities                DBC   (2006-02), QRACX (1997-03)
      "GLD")  # Gold                       GLD   (2004-11), SGGDX (1993-08), IAU (2005-01, lower ER than GLD)

# US Real Estate: WILLRESIND  (FRED)
# Commodities: ^SPGSCI        (YAHOO)

# SPY, EZU, EWJ, EEM, VNQ, RWX, IEF, TLT, DBC, GLD

asset_table <- read.csv(text = "ETF,ETF Start,Fund,Fund Start
US Equity,                  VTI, 2001-05, VTSMX, 1992-04
European Equity,            VGK, 2005-03, VEURX, 1990-06
Japanese Equity,            EWJ, 1996-03, FJPNX, 1992-12
Emerging Market Equity,     EEM, 2003-04, VEIEX, 1994-12
US Real Estate,             ICF, 2001-02, VGSIX, 1996-05
International Real Estate,  RWX, 2006-12, XRFIX, 1997-09
Intermediate Term Treasury, IEF, 2002-07, VFITX, 1991-12
Long Term Treasury,         TLT, 2002-07, VUSTX, 1986-12
Commodities,                DBC, 2006-02, QRACX, 1997-03
Gold,                       GLD, 2004-11, SGGDX, 1993-08",
strip.white = TRUE, check.names = FALSE)

# ETF/Fund pairs
assets <- data.frame(t(asset_table[, c(1, 3)]))

if (file.exists("returns.rds")) {
    returns <- readRDS("returns.rds")
} else {
    return_history <- do.call(merge, lapply(assets, import_spliced_returns))
    returns <- return_history

    # Replace missing returns with GSCI index from Yahoo Finance
    gsci <- Ad(getSymbols("^SPGSCI", from = "1990-01-01", src = "yahoo", auto.assign = FALSE))
    asset_col <- "Commodities"
    returns[, asset_col] <- splice_returns(returns[, asset_col], Return.calculate(gsci))

    # Replace missing returns with Russell Global Real Estate Securities Fund
    global_re <- Ad(getSymbols("RRESX", from = "1990-01-01", src = "tiingo", auto.assign = FALSE))
    asset_col <- "International.Real.Estate"
    returns[, asset_col] <- splice_returns(returns[, asset_col], Return.calculate(global_re))

    # Replace missing returns with Willshire Real Estate Securities index from FRED
    # Daily data start in 1996-01-31
    us_re <- getSymbols("WILLRESIND", from = "1996-01-31", src = "FRED", auto.assign = FALSE)
    asset_col <- "US.Real.Estate"
    returns[, asset_col] <- splice_returns(returns[, asset_col], Return.calculate(us_re))

    returns <- na.omit(returns)

    saveRDS(returns, file = "returns.rds")
}

# Only use data through the end of 2014
returns <- returns["/2014"]





## ----asset_table, echo=FALSE--------------------------------------------------
suppressWarnings({
tbl <- kbl(asset_table,
           caption = "Data Sources by Date",
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE) |>
       column_spec(1, "2.0in") |>
       column_spec(2, "0.5in") |>
       column_spec(3, "1.0in") |>
       column_spec(4, "0.5in") |>
       column_spec(5, "1.0in")
kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})


## ----helper_functions, echo=FALSE---------------------------------------------
# convert daily returns to monthly
to_monthly_returns <-
function(returns) {
    apply.monthly(returns, Return.cumulative)
}

# calculate strategy statistics
strat_summary <-
function(returns,
         colname = "Returns",
         original_results = NULL)
{
    if (!require("PerformanceAnalytics", quietly = TRUE)) {
        stop("please install the PerformanceAnalytics package")
    }

    stats <- table.AnnualizedReturns(returns)
    stats <- rbind(stats,
                   "Worst Drawdown" = -maxDrawdown(returns))
    colnames(stats) <- "Replication"

    if (!is.null(original_results)) {
        stats <- cbind(stats, original_results)
        colnames(stats)[2] <- "Original"
    }

    stats <- round(stats, 3)

    return(stats)
}


## ----equal_weight, echo=TRUE--------------------------------------------------
returns_equal_weight <- as.xts(apply(returns, 1, mean))
monthly_returns <- to_monthly_returns(returns_equal_weight)

title <- "All Assets - Equal Weight"
stats <- strat_summary(monthly_returns, title,
                       original_results = c(0.081, 0.112, 0.72, -0.392))
charts.PerformanceSummary(monthly_returns, main = title, wealth.index = TRUE)


## ----equal_weight_table-------------------------------------------------------
suppressWarnings({
tbl <- kbl(stats,
           caption = title,
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE)

kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})


## ----equal_risk_functions, echo=FALSE, results=FALSE--------------------------
estimate_equal_risk_portf <-
function(returns, n_days = 60)
{
    if (!requireNamespace("FRAPO", quietly = TRUE)) {
        stop("please install the FRAPO package")
    }
    n_day_returns <- last(returns, n_days)
    sigma <- cov(n_day_returns)

    capture.output({  # this optimization function is chatty
        optim_portf <- FRAPO::PERC(sigma, percentage = FALSE)
    })

    return(FRAPO::Weights(optim_portf))
}

portf_equal_risk <-
function(returns,
         n_days = 120,
         n_days_vol = 60)
{
    month_end_i <- endpoints(returns, "months")       # rebalance monthly
    month_end_i <- month_end_i[month_end_i > n_days]  # skip 'n_days'
    weights <- returns * NA                           # pre-allocate

    # calculate portfolio weights using the prior 'n_days'
    for (i in month_end_i) {
        n_day_returns <- returns[(i - n_days):i, ]
        weights[i,] <- estimate_equal_risk_portf(n_day_returns, n_days_vol)
    }

    weights <- lag(weights)      # use prior month-end weights
    weights <- na.locf(weights)  # fill weights for all days

    xts(rowSums(returns * weights), index(returns))
}

checkUsage(estimate_equal_risk_portf)
checkUsage(portf_equal_risk)


## ----equal_risk, echo=TRUE----------------------------------------------------
returns_equal_risk <- portf_equal_risk(returns, 120, 60)
monthly_returns <- to_monthly_returns(returns_equal_risk)

title <- "All Assets - Equal Risk Contribution"
stats <- strat_summary(monthly_returns, title,
                       original_results = c(0.085, 0.086, 0.99, -0.242))
charts.PerformanceSummary(monthly_returns, main = title, wealth.index = TRUE)


## ----equal_risk_table, eval=TRUE----------------------------------------------
suppressWarnings({
tbl <- kbl(stats,
           caption = title,
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE)

kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})


## ----top5_momo_eq_weight_functions, echo=FALSE, results=FALSE-----------------
portf_top_momentum <-
function(returns,
         n_assets = 5,
         n_days = 120)
{
    month_end_i <- endpoints(returns, "months")       # rebalance monthly
    month_end_i <- month_end_i[month_end_i > n_days]  # skip 'n_days'
    weights <- returns * NA                           # pre-allocate

    # calculate portfolio components and weights using the prior 'n_days'
    for (i in month_end_i) {
        # total returns for each asset class over the prior 'n_days'
        n_day_returns <- returns[(i - n_days):i, ]
        momentum_returns <- apply(1 + n_day_returns, 2, prod) - 1

        # find 'n_assets' with highest total return over previous 'n_days'
        momentum_rank <- order(momentum_returns, decreasing = TRUE)
        top_n_loc <- head(momentum_rank, n_assets)

        # set all weights to 0, then equal-risk-weight the top 'n_assets'
        weights[i, ] <- 0
        weights[i, top_n_loc] <- 1 / n_assets
    }

    weights <- lag(weights)      # use prior month-end weights
    weights <- na.locf(weights)  # fill weights for all days

    xts(rowSums(returns * weights), index(returns))
}

checkUsage(portf_top_momentum)


## ----top5_momo_eq_weight, echo=TRUE-------------------------------------------
returns_momentum_equal_weight <- portf_top_momentum(returns, 5, 120)
monthly_returns <- to_monthly_returns(returns_momentum_equal_weight)

title <- "Top 5 Assets by 6-month Momentum - Equal Weight"
stats <- strat_summary(monthly_returns, title,
                       original_results = c(0.130, 0.110, 1.17, -0.217))
charts.PerformanceSummary(monthly_returns, main = title, wealth.index = TRUE)


## ----top_5_momo_eq_weight_table, echo=FALSE-----------------------------------
suppressWarnings({
tbl <- kbl(stats,
           caption = title,
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE)

kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})


## ----top_momo_eq_risk_functions, echo=FALSE, results=FALSE--------------------
portf_top_momentum_equal_risk <-
function(returns,
         n_assets = 5,
         n_days = 120,
         n_days_vol = 60)
{
    month_end_i <- endpoints(returns, "months")       # rebalance monthly
    month_end_i <- month_end_i[month_end_i > n_days]  # skip 'n_days'
    weights <- returns * NA                           # pre-allocate

    # calculate portfolio components and weights using the prior 'n_days'
    for (i in month_end_i) {
        # total returns for each asset class over the prior 'n_days'
        n_day_returns <- returns[(i - n_days):i, ]
        momentum_returns <- apply(1 + n_day_returns, 2, prod) - 1

        # portfolio will always be invested, even if momentum is negative

        # find 'n_assets' with highest total return over previous 'n_days'
        momentum_rank <- order(momentum_returns, decreasing = TRUE)
        top_cols <- head(momentum_rank, n_assets)

        # set all weights to 0, then equal-risk-weight the top 'n_assets'
        weights[i, ] <- 0
        weights[i, top_cols] <-
            estimate_equal_risk_portf(n_day_returns[, top_cols], n_days_vol)
    }

    weights <- lag(weights)      # use prior month-end weights
    weights <- na.locf(weights)  # fill weights for all days

    return(xts(rowSums(returns * weights), index(returns)))
}

checkUsage(portf_top_momentum_equal_risk)


## ----top_momo_eq_risk, echo=TRUE----------------------------------------------
returns_top_momentum_equal_risk <-
    portf_top_momentum_equal_risk(returns, 5, 120, 60)
monthly_returns <- to_monthly_returns(returns_top_momentum_equal_risk)

title <- "Top 5 Assets by 6-month Momentum - Equal Risk Contribution"
stats <- strat_summary(monthly_returns, title,
                       original_results = c(0.140, 0.099, 1.41, -0.148))
charts.PerformanceSummary(monthly_returns, main = title, wealth.index = TRUE)


## ----top_5_momo_eq_risk_table, echo=FALSE-------------------------------------
suppressWarnings({
tbl <- kbl(stats,
           caption = title,
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE)

kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})


## ----top_momo_min_var_functions, echo=FALSE, results=FALSE--------------------
estimate_min_var_portf <-
function(returns, n_days_vol = 20)
{
    # the covariance matrix is the correlation using all returns, but
    # the volatility of the past 'n_days_vol'
    vol_returns <- last(returns, n_days_vol)
    sigma <- tcrossprod(apply(vol_returns, 2, sd)) * cor(returns)
    sigma <- cov(vol_returns)

    Ra <- as.matrix(returns)
    min_var_portf <- portfolio.optim(x = Ra, covmat = sigma)
    weights <- round(min_var_portf$pw, 7)
    return(weights)
}

portf_top_momentum_min_var <-
function(returns,
         n_assets = 5,
         n_days = 120,
         n_days_vol = 60)
{
    month_end_i <- endpoints(returns, "months")       # rebalance monthly
    month_end_i <- month_end_i[month_end_i > n_days]  # skip 'n_days'
    weights <- returns * NA                           # pre-allocate

    # calculate portfolio components and weights using the prior 'n_days'
    for (i in month_end_i) {
        n_day_returns <- returns[(i - n_days):i, ]
        momentum_returns <- apply(1 + n_day_returns, 2, prod) - 1

        # momentum must be positive and above average
        top_cols <- momentum_returns > mean(momentum_returns)
        weights[i, ] <- 0

        if (sum(top_cols) >= 2) {
            # need at least 2 assets to calculate non-zero weights

            momentum_rank <- order(momentum_returns, decreasing = TRUE)
            top_cols <- head(momentum_rank, n_assets)

            weights[i, top_cols] <-
                estimate_min_var_portf(n_day_returns[, top_cols], n_days_vol)
        }
    }

    weights <- lag(weights)      # use prior month-end weights
    weights <- na.locf(weights)  # fill weights for all days

    xts(rowSums(returns * weights), index(returns))
}

checkUsage(estimate_min_var_portf)
checkUsage(portf_top_momentum_min_var)


## ----top_momo_min_var, echo=TRUE----------------------------------------------
returns_momentum_min_var <-
    portf_top_momentum_min_var(returns, 5, 120, 60)
monthly_returns <- to_monthly_returns(returns_momentum_min_var)

title <- "Assets With Above Average 6-month Momentum - Minimum Variance"
stats <- strat_summary(monthly_returns, title,
                       original_results = c(0.150, 0.094, 1.60, -0.088))
charts.PerformanceSummary(monthly_returns, main = title, wealth.index = TRUE)


## ----top_5_momo_min_var_table, echo=FALSE-------------------------------------
suppressWarnings({
tbl <- kbl(stats,
           caption = title,
           format = "pipe",
           booktabs = TRUE,
           linesep = "",
           escape = TRUE)

kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
})

