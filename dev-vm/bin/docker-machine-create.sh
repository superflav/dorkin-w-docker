#!/bin/bash

MACHINE_NAME=${MACHINE_NAME:-"dev"}
MACHINE_MEMORY=${MACHINE_MEMORY:-"8192"}
MACHINE_CPU_COUNT=${MACHINE_CPU_COUNT:-"4"}
MACHINE_DISK_SIZE=${MACHINE_DISK_SIZE:-"50000"}

if which -s docker-machine; then
  # docker engine accessible via docker-machine (osx, windows)
  docker-machine create -d virtualbox --virtualbox-memory=${MACHINE_MEMORY} --virtualbox-cpu-count=${MACHINE_CPU_COUNT} --virtualbox-disk-size=${MACHINE_DISK_SIZE} ${MACHINE_NAME} || true
else
  echo "This only runs if docker-machine is installed"
fi
