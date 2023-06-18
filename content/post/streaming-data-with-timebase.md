---
title: 'Streaming Market Data with TimeBase'
date: 2023-06-17T10:14:00.000-05:00
draft: false
tags : [Data]
---

This is the first post of a series on using [TimeBase](https://timebase.info/) to stream real-time market data. TimeBase is a high performance event-based time series database and message broker. I used it on a proprietary trading desk that was a futures market maker and currently use it to build and test equity trading strategies. It was [released as open-source](https://github.com/finos/TimeBase-CE/) in February 2021.

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

[TimeBase](https://timebase.info/) addresses several key needs in automated trading.

You need to process large amounts of real-time market data. The data needs to be processed quickly and absolutely must be processed in strict time order. This is not trivial when you need to interleave real-time data from multiple sources (e.g. exchanges). The data should be stored for analysis and debugging.


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

**The message bus** provides a [publish/subscribe](https://en.wikipedia.org/wiki/Publish%E2%80%93subscribe_pattern) pattern to write/read streaming data. The data is processed via readers and writers to [streams](https://kb.timebase.info/community/overview/streams). Readers can consume multiple streams simultaneously and the messages from every stream are interleaved so that every message consumed is always in guaranteed time order regardless of which stream they come from. It is extremely important that ever consumer receives data strictly sequenced by time!

There are two types of streams, durable and transient. Durable streams are persisted to disk. Transient streams are only in memory and can be *lossy* or *lossless*.
  * Writers to *lossy* streams are not blocked by slow readers, so slow readers may not receive every message but always receive the next available message once they finish processing a message.

  * Writers to *lossless* streams are blocked by slow readers, so every reader always receives every message and every reader can only process data as fast as the slowest reader. Writers can only write to one stream.


**The database** handles reading/writing data from/to disk, importing and exporting data, replicating data to other applications, and can aggregate data to regular bars. It has a query language ([QQL](https://kb.timebase.info/community/development/qql/QQL%205.5/qql-tut-intro)) you can use to extract, filter, aggregate, and transform data in streams.

There's also an open-source [Web Administrator](https://kb.timebase.info/community/development/tools/Web%20Admin/admin_config_ce) you can use to manipulate streams (create, delete, edit, import/export). It also allows you to view data, including monitoring live data streaming in to the database.

Anything else should I cover in this post?

{{< post-footer id="post-footer.html" >}}
