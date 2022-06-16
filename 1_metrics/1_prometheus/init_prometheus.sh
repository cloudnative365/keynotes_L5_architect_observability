#!/bin/bash
useradd -s /sbin/nologin prometheus
cd /app/src
wget https://github.com/prometheus/prometheus/releases/download/v2.35.0/prometheus-2.35.0.linux-amd64.tar.gz
tar xf prometheus-2.35.0.linux-amd64.tar.gz
cd prometheus-2.35.0.linux-amd64

mv prometheus promtool /usr/local/sbin/
chown -R prometheus:prometheus /usr/local/sbin/prometheus /usr/local/sbin/promtool

mkdir /var/lib/prometheus
mv console_libraries consoles /var/lib/prometheus
chown -R prometheus:prometheus /var/lib/prometheus

mkdir /etc/prometheus/
mv prometheus.yml /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/

mkdir /app/prometheus/
chown -R prometheus:prometheus /app/prometheus/
