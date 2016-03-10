#!/bin/bash

MACHINE_NAME=${MACHINE_NAME:-"dev"}

docker-machine stop $MACHINE_NAME
docker-machine rm $MACHINE_NAME
