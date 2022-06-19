#!/bin/bash
cd /app/src
wget https://dl.min.io/server/minio/release/linux-amd64/minio
mv minio /usr/local/sbin
chmod +x /usr/local/sbin/minio

wget https://dl.min.io/client/mc/release/linux-amd64/mc
mv mc /usr/local/sbin
chmod +x /usr/local/sbin/mc

mkdir -p /app/minio/data && mkdir /etc/minio && mkdir /app/minio/run

wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/4_minio/minio.service
mv minio.service /etc/systemd/system/minio.service

systemctl daemon-reload
systemctl start minio
systemctl enable minio
