suppressPackageStartupMessages({
    #library(PerformanceAnalytics)
    library(quantmod)
    library(tseries)
    library(kableExtra)
    library(knitr)
    knitr::opts_chunk$set(
        eval = TRUE,
        echo = FALSE,
        fig.width = 7,
        fig.height = 6
    )

    options(digits.secs = 6,
            xts_check_TZ = FALSE)
    Sys.setenv(TZ = "UTC")
})

strat_stat_table <-
function(returns,
         colname = "Returns",
         caption = "Strategy Result Summary",
         original_results = NULL)
{
    stats <- strat_summary(returns, colname, original_results)

    if (!is.null(original_results)) {
        stats <- cbind(stats, original_results)
        colnames(stats)[2] <- "Original"
    }
    stats <- round(stats, 3)

    if (interactive()) {
        return(stats)
    } else {
        tbl <- kbl(stats,
                   caption = caption,
                   format = "latex",
                   booktabs = TRUE,
                   linesep = "",
                   escape = TRUE)
        tbl <- kable_classic(tbl, full_width = FALSE, latex_options = "hold_position")
        return(tbl)
    }
}

evaluate_results <-
function(returns,
         dates = "/",
         title = "Performance Summary",
         original_results = NULL)
{
    r <- returns[dates]
    cat("\n")
    PerformanceAnalytics::charts.PerformanceSummary(r, main = title, wealth.index = TRUE)
    strat_stat_table(r, caption = title, original_results = original_results)
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

    # order colums
    prices <- prices[, symbols]

    # calculate returns
    returns <- Return.calculate(prices)

    na_etf_returns <- is.na(returns[, 1])
    returns[na_etf_returns, 1] <- returns[na_etf_returns, 2]

    colnames(returns) <- NULL

    return(returns[,1])
}
