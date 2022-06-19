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
cd /etc/prometheus
wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/1_prometheus/prometheus-B.yml
mv prometheus_B.yml /etc/prometheus/prometheus.yml
chown -R prometheus:prometheus /etc/prometheus/

mkdir /app/prometheus/
chown -R prometheus:prometheus /app/prometheus/

wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/1_prometheus/prometheus_systemd
mv prometheus_systemd /etc/systemd/system/prometheus.service

systemctl daemon-reload
systemctl start prometheus
