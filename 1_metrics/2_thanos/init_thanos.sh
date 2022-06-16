#!/bin/bash
wget https://github.com/thanos-io/thanos/releases/download/v0.26.0/thanos-0.26.0.linux-amd64.tar.gz
tar xf https://github.com/thanos-io/thanos/releases/download/v0.26.0/thanos-0.26.0.linux-amd64.tar.gz
cd thanos-0.26.0.linux-amd64
mv thanos /usr/local/sbin
