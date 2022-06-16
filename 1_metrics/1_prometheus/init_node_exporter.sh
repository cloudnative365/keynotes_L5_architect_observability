#!/bin/bash
cd /app/src
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar xf node_exporter-1.3.1.linux-amd64.tar.gz
cd node_exporter-1.3.1.linux-amd64
mv node_exporter /usr/local/sbin/

wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/1_prometheus/node_exporter_systemd
mv node_exporter_systemd /etc/systemd/system/node_exporter.service

systemctl daemon-reload
systemctl start node_exporter
