#!/bin/bash

echo "RRRRreseting clock"
curl http://192.168.1.6/turn-on
sleep 5
curl http://192.168.1.6/turn-off
