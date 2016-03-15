SHELL := /bin/bash
IMAGE_NAME_BASE := atscale
# image name
IMAGE_NAME := ${IMAGE_NAME_BASE}/${OS}
# id of the container that's running the image
CONTAINER_ID := $(shell docker ps | grep "\s${IMAGE_NAME}\s" | awk '{print $$1}')
# name of the Dockerfile
DOCKERFILE := Dockerfile
# ports which are published to the host system's interfaces
PORTS_TO_PUBLISH := -p 10500-10520:10500-10520 -p 11111-11199:11111-11199 -p 8088:8088 -p 50070:50070
# list of host:ip which will be added to the container's /etc/hosts file
HOSTS_TO_ADD := --add-host=${DOCKER_HOST_NAME}:${DOCKER_IP}
# default ssh user, can be overridden on the CLI, like SSH_USER=root
SSH_USER ?= atscale

####
## Image and container-specific targets
###
all: build

# build the image
build: init clean
	docker build -f ${OS}/${DOCKERFILE} -t ${IMAGE_NAME} .

# run a container using the image, and drop into interactive bash shell
run: init clean
	docker run --rm -it ${HOSTS_TO_ADD} ${PORTS_TO_PUBLISH} ${IMAGE_NAME} /bin/bash

# run a container using the image in detached (daemon) mode
run-daemon: init clean
	docker run -d ${PORTS_TO_PUBLISH} ${IMAGE_NAME}

# ssh into the running container
ssh: init
	docker exec -u ${SSH_USER} -it ${CONTAINER_ID} /bin/bash;

# stop the running container
stop: init
	docker stop ${CONTAINER_ID};

# tag the image
tag: init
	@if [ -z "${TAG}" ]; then \
		echo "'TAG' var missing: 'make TAG=<tag> tag'"; \
	else \
		docker tag ${IMAGE_NAME} ${IMAGE_NAME}:${TAG}; \
	fi

####
## intialization & debugging targets
####
init: check_docker set_dir

check_docker:
	@if ! docker ps -q; then \
		echo ""; \
		echo "Try running this command in the current terminal window 1st:"; \
		echo "source ./bin/update-docker-host.sh"; \
		echo ""; \
		exit 1; \
	fi

set_dir:
	@if [ -z "${OS}" ]; then \
		echo "Required 'OS' var missing: 'make OS=<operating_system> <target>'"; \
		echo "Supported OS values are: 'centos6', 'ubuntu14.04'"; \
		exit 1; \
	elif [ ! -d "${OS}" ]; then  \
		echo "'${OS}' is not a supported operating system"; \
		echo "Supported OS values are: 'centos6', 'ubuntu14.04'"; \
		exit 1; \
	elif [ ! -f "${OS}/${DOCKERFILE}" ]; then \
		echo "Dockerfile ${OS}/${DOCKERFILE} does not exist"; \
		exit 1; \
	fi

debug: init
	@echo "OS: ${OS}"
	@echo "IMAGE_NAME_BASE: ${IMAGE_NAME_BASE}"
	@echo "IMAGE_NAME: ${IMAGE_NAME}"
	@echo "CONTAINER_ID: ${CONTAINER_ID} (empty if image container not running)"
	@echo "DOCKERFILE: ${DOCKERFILE}"
	@echo "PORTS_TO_PUBLISH: ${PORTS_TO_PUBLISH}"
	@echo "HOSTS_TO_ADD: ${HOSTS_TO_ADD}"
	@echo "TAG: ${TAG}"

####
## General housekeeping targets, not image or container-specific
####
clean: clean-exited-containers clean-untagged-images

clean-exited-containers:
	docker rm $(shell docker ps -aq --no-trunc --filter status=exited) || true

clean-untagged-images:
	docker rmi $(shell docker images -f "dangling=true" -q) || true
