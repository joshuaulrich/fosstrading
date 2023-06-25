---
title: 'Streaming Market Data with TimeBase'
date: 2023-06-19T12:14:00.000-05:00
draft: false
aliases: [ "/2023/06/streaming-data-with-timebase.html" ]
tags : [Data, TimeBase]
---

This is the first post of a series on using [TimeBase](https://timebase.info/) to stream real-time market data. TimeBase is a high performance event-based time series database and message broker. I used it on a proprietary trading desk that made markets in futures, and currently use it to build and test equity trading strategies. It was [released as open-source](https://github.com/finos/TimeBase-CE/) in February 2021.

<!--more-->

<!--
Posts:
1. Intro
2. Build and run TimeBase from source/Docker
3. Build and run Web Admin from source/Docker
4. Setting up a data connector
5. Intro do the Web Admin

* aggregate data to bars
* export to CSV
-->

### What's Your Problem?


<!--
I thought it might not be clear to everyone what you might be doing with the real-time and static data here

i.e. real-time: aggregating tick data over some window to create time series features for trading decisions etc.
stored-data: for quantitative analysis of market effects, or your own trading.

-->

[TimeBase](https://timebase.info/) addresses several key needs in automated trading. You need to process large amounts of real-time market data. This includes trades, best bid/offer, and/or the entire limit order book. You use this data to calculate indicators/features, determine when and where to place orders, monitoring unrealized P&L, and monitoring/managing risk of your positions.

All data in the trading system needs to be processed quickly and absolutely must be processed in strict time order. This is not trivial when you need to interleave data from multiple sources (e.g. exchanges and the trading system itself).
The [System Architecture](https://medium.com/prooftrading/proof-engineering-the-algorithmic-trading-platform-b9c2f195433d#d545) section of "The Algorithmic Trading Platform" by Prerak Sanghvi describes the benefits of using a strictly time-sequenced stream of events. To summarize:
* Synchronized: every system component always receives the same data in the same order.
* Observable: the system is deterministic and can be debugged offline by replaying the data.
* Auditable: You can re-create the state of the system at any point in time.
* Streamlined: Tasks like logging and persisting to disk can be delegated to components that are off the critical path.

The data also needs be stored for analysis and debugging. Analysis includes things like running backtests, post-trade evaluation, and investigating market behavior. ["Selecting a Database for an Algorithmic Trading System"
](https://medium.com/prooftrading/selecting-a-database-for-an-algorithmic-trading-system-2d25f9648d02) by Prerak Sanghvi discusses the necessary components of a time-series database for algorithmic trading. To summarize:
* Fast data ingest: millions of records per second (quote data can be 100+ million records per day)
* Ability to process large amounts of historical data for patterns and trends
* Time series operations and real-time analytics (e.g. window functions, aggregations, as-of joins)
* Expressive query language
* Optimized on-disk layout

### TimeBase vs Alternatives

Why use TimeBase instead of other open-source projects like [RabbitMQ](https://www.rabbitmq.com/), [Kafka](https://kafka.apache.org/), [InfluxDB](https://www.influxdata.com/), [TimeScaleDB](https://www.timescale.com/), or [ClickHouse](https://clickhouse.com/)? The main reason is that TimeBase is both a [message broker](https://en.wikipedia.org/wiki/Message_broker) *and* a [time-series database](https://en.wikipedia.org/wiki/Time_series_database). The TimeBase website has its own ["Why TimeBase" page](https://timebase.info/why-timebase/) and pages that compare popular [time-series databases](https://timebase.info/why-timebase/tsdb-comparison.html) and [message brokers](https://timebase.info/why-timebase/message-brokers-comparison.html). Here's a summary of the benefits of TimeBase from those pages:

* Based on configuration, it supports microsecond latencies or the ability to handle millions of messages per second on commodity hardware.
* Enforces stream schemas with heterogeneous and potentially complex [message structures](https://kb.timebase.info/community/overview/messages).
* The same [APIs](https://kb.timebase.info/community/development/libs) can be used to stream real-time data *and* replay historical data.
* Able to [replicate data](https://kb.timebase.info/community/technology/replication/replication_intro) to other TimeBase instances or applications.
* The open-source community edition has multiple crypto exchange data connectors. The enterprise edition has 50+ built-in data connectors.

### TimeBase Structure

This is a high-level summary of the [TimeBase architecture page](https://timebase.info/architecture.html).

**Data connectors** handle connecting to external data sources and translating their data into the TimeBase format. There are many open source [crypto exchange data connectors](https://github.com/epam/TimebaseCryptoConnectors). The enterprise edition has another 50+ data connectors to all major exchanges and many data vendors.

**The message broker** provides a [publish/subscribe](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) pattern to write/read streaming data. The data is processed via readers and writers to [streams](https://kb.timebase.info/community/overview/streams).

Writers can only write to one stream. Readers can consume multiple streams simultaneously and the messages from every stream are interleaved so that every message consumed is always in guaranteed time order regardless of which stream they come from. It is extremely important that every consumer receives data strictly sequenced by time!

There are two types of streams, durable and transient. Durable streams are persisted to disk. Transient streams are only in memory and can be *lossy* or *lossless*.
  * Writers to *lossy* streams are not blocked by slow readers, so slow readers may not receive every message but always receive the next available message once they finish processing a message.

  * Writers to *lossless* streams are blocked by slow readers, so every reader always receives every message and every reader can only process data as fast as the slowest reader.


**The database** handles reading/writing data from/to disk, importing and exporting data, replicating data to other applications, and can aggregate data to regular bars. It has a query language ([QQL](https://kb.timebase.info/community/development/qql/QQL%205.5/qql-tut-intro)) you can use to extract, filter, aggregate, and transform data in streams.

There's also an open-source [Web Administrator](https://kb.timebase.info/community/development/tools/Web%20Admin/admin_config_ce) you can use to manipulate streams (create, delete, edit, import/export). It also allows you to view data, including monitoring live data streaming in to the database.

### What's Next?

Later posts in this series will cover at least the topics below. Please leave a comment or contact me with any other things you would like to see!

* Building and running TimeBase from source/Docker
* Building and running the Web Administrator from source/Docker
* Setting up a data connector
* Introduction to the Web Administrator (viewing/monitoring data, import/export)
* Introduction to QQL, the quant query language

Thanks to [TheRobotJames](https://robotjames.com/) for helpful feedback!

{{< post-footer id="post-footer.html" >}}
