#!/bin/bash

yum install -y nginx

wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/3_nginx/thanos-query.conf
wget https://raw.githubusercontent.com/cloudnative365/keynotes_L5_architect_observability/main/1_metrics/3_nginx/minio.conf
mv thanos-query.conf /etc/nginx/conf.d
mv minio.conf /etc/nginx/conf.d

systemctl enable nginx
systemctl start nginx
