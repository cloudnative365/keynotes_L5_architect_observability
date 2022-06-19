#!/bin/bash
cd /app/src/
wget https://github.com/thanos-io/thanos/releases/download/v0.26.0/thanos-0.26.0.linux-amd64.tar.gz
tar xf thanos-0.26.0.linux-amd64.tar.gz
cd thanos-0.26.0.linux-amd64
mv thanos /usr/local/sbin

mkdir /app/thanos
mkdir /app/thanos/compact
mkdir /app/thanos/store
mkdir /app/thanos/ruler

mkdir /etc/thanos

wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/2_thanos/thanos-sidecar.service
wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/2_thanos/thanos-query.service

mv thanos-sidecar.service /etc/systemd/system/
mv thanos-query.service /etc/systemd/system/

systemctl daemon-reload
systemctl start thanos-sidecar
systemctl start thanos-query

systemctl enable thanos-sidecar
systemctl enable thanos-query
