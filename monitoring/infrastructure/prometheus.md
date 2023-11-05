# Prometheus

## installation

### docker compose

### systemd

- [install prometheus](https://www.cherryservers.com/blog/install-prometheus-ubuntu)

- [install pushgateway](https://blog.ruanbekker.com/blog/2019/05/17/install-pushgateway-to-expose-metrics-to-prometheus/)

## introduction

- prometheus is an open-source monitoring solution & time series database which provides metrics & alerting with a flexible `Query Language`.

- originally built by soundcloud in 2012 and jointed to `Cloud Native Computing Foundation (CNCF)` in 2016.

- in prometheus we have `Dimensional Data` which identified by metric name and a set of key/value pairs (labels).

- visualizations can be shown using buil-in expression browser or with integrations like `Grafana`.

- it stores metrics in `memory` and `local disk` in an own and efficient format.

- written in `Go` and many client libraries are available

- prometheus collect metrics from monitored targets by scraping metrics HTTP endpoints.

- some monitoring solutions will use custom scripts runs on the server alongside application but scraping endpoints are much more efficient than other mechanism.

- a single prometheus server is able to ingest up to one milion samples per second as several milion time series.

### concepts

- every time series is identified by a `metric name` and a set of key-value pairs called `labels` like `go_alloc_bytes{instance="localhost",job="worker"}` which `go_alloc_bytes` is metric name and the `{instance="localhost",job="worker"}` are labels.

- time series data also contains actual data called `samples`. (number of times a metric happend)

### configuration

``` bash
vim /etc/prometheus/prometheus.yml
```

- the configuration can be applied at runtime with a reload in prometheus server

- the parameters are given at start time and in order to change them you need to restart your server.

- the prometheus itself exposes some metrics at `localhost:9090/metrics` and the web console of prometheus is accessible at `localhost:9090`

### node exporter

- a project owned by prometheus

- it will export the machine statistics like RAM and CPU as HTTP endpoint which prometheus can escrape it.

- normally starts at port 9100 of that machine

    ```bash
    curl localhost:9100
    curl localhost:9100/metrics
    ```

### [Architecture](https://github.com/prometheus/prometheus#architecture-overview)

### storage

- can be default local storage or remote storage system like postgresql or influxdb
