#!/bin/sh
nohup python3 -m http.server --bind 0.0.0.0 8888 > /tmp/weblog.txt 2>&1 &

