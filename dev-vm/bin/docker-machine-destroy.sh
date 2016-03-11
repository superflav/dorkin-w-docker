#!/bin/bash

MACHINE_NAME=${MACHINE_NAME:-"dev"}

if which docker-machine; then
  # docker engine accessible via docker-machine (osx, windows)
  docker-machine stop ${MACHINE_NAME}
  docker-machine rm --force ${MACHINE_NAME}
else
  echo "This only runs if docker-machine is installed"
fi
