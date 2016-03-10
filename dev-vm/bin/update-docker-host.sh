#!/bin/bash

MACHINE_NAME=${MACHINE_NAME:-"dev"}

export DOCKER_HOST_NAME="docker.local"

####
# set DOCKER_IP env var
####
if which docker-machine; then
  # docker engine accessible via docker-machine (osx, windows)

  # if this is good, run the rest
  docker-machine status ${MACHINE_NAME}

  if [ $? -eq 0 ]; then
    # configure shell w/DOCKER env vars
    eval "$(docker-machine env ${MACHINE_NAME})"

    # export ip of running machine
    export DOCKER_IP=$(docker-machine ip ${DOCKER_MACHINE_NAME})
  else
    echo "docker-machine host '${MACHINE_NAME}' does not exist. Try running $(dirname $0)/docker-machine-create.sh first."
    unset DOCKER_IP
  fi
else
  # docker engine running locally (linux)
  export DOCKER_IP=127.0.0.1
fi

####
## update /etc/hosts
####
if [ -n "${DOCKER_IP}" ]; then
  if ! grep -q -E "^${DOCKER_IP}[[:space:]]+${DOCKER_HOST_NAME}$" /etc/hosts; then
    # "${DOCKER_IP} ${DOCKER_HOST_NAME}" line is not in /etc/hosts
    echo "Updating /etc/hosts with the ip address (${DOCKER_IP}) for ${DOCKER_HOST_NAME}"

    # clear existing ${DOCKER_HOST_NAME} entry from /etc/hosts
    sudo sed -i '' "/[[:space:]]${DOCKER_HOST_NAME}$/d" /etc/hosts

    # append docker ip + host line to /etc/hosts
    [[ -n $DOCKER_IP ]] && sudo /bin/bash -c "echo \"${DOCKER_IP} ${DOCKER_HOST_NAME}\" >> /etc/hosts"
  fi
else
  echo "DOCKER_IP IS NULL!! ${DOCKER_IP}"
fi
