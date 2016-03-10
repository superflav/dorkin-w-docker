#!/bin/bash

MACHINE_NAME=${MACHINE_NAME:-"dev"}

docker-machine create -d virtualbox --virtualbox-memory=8192 --virtualbox-cpu-count=4 --virtualbox-disk-size=50000 $MACHINE_NAME
