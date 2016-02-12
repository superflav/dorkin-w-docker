SHELL := /bin/bash
IMAGE_NAME_BASE := atscale
# image name when everything but atscale is installed
IMAGE_NAME := ${IMAGE_NAME_BASE}/$(shell echo $${PWD\#\#*/})
# image name when everything including atscale is installed
IMAGE_NAME_ATSCALE_INSTALLED := ${IMAGE_NAME}-atscale
# id of the container that's running the base image
CONTAINER_ID := $(shell docker ps | grep "\s${IMAGE_NAME}\s" | awk '{print $$1}')
# id of the container that's running the atscale-installed image
CONTAINER_ID_ATSCALE_INSTALLED := $(shell docker ps | grep "\s${IMAGE_NAME_ATSCALE_INSTALLED}\s" | awk '{print $$1}')
# ports which are published to the host system's interfaces
PORTS_TO_PUBLISH := -p 10500-10520:10500-10520 -p 11111-11199:11111-11199 -p 8088:8088 -p 50070:50070
# list of host:ip which will be added to the container's /etc/hosts file
HOSTS_TO_ADD := --add-host=${DOCKER_HOST_NAME}:${DOCKER_IP}

all: build

# build the base image, without installing atscale
build:
	docker build -t ${IMAGE_NAME} .

# build the base + atscale installed image by first building the base image,
# then running a container from the base image, and finally committing the
# resulting container as a new image
# TODO: this doesn't work yet - probably want to have another Dockerfile that extends the base image
build-atscale-installed: build run
	docker commit ${CONTAINER_ID} ${IMAGE_NAME_ATSCALE_INSTALLED}

# run a container using the base image, and drop into interactive bash shell
run:
	# docker run -it --name ${CONTAINER_NAME} ${PORTS_TO_PUBLISH} ${IMAGE_NAME} /bin/bash
	docker run -it ${HOSTS_TO_ADD} ${PORTS_TO_PUBLISH} ${IMAGE_NAME} /bin/bash

# run a container using the atscale-installed image, and drop into interactive bash shell
run-atscale-installed:
	# docker run -it --name ${CONTAINER_NAME} ${PORTS_TO_PUBLISH} ${IMAGE_NAME} /bin/bash
	docker run -it ${HOSTS_TO_ADD} ${PORTS_TO_PUBLISH} ${IMAGE_NAME_ATSCALE_INSTALLED} /bin/bash

# run a container using the base image in detatched (daemon) mode
run-daemon:
	docker run -d ${PORTS_TO_PUBLISH} ${IMAGE_NAME}

# run a container using the atscale-installed image in detatched (daemon) mode
run-daemon-atscale-installed:
	docker run -d ${PORTS_TO_PUBLISH} ${IMAGE_NAME_ATSCALE_INSTALLED}

# ssh into the running container
ssh:
	@if [ -n "${CONTAINER_ID}" ]; then \
		docker exec -it ${CONTAINER_ID} /bin/bash; \
	else \
		docker exec -it ${CONTAINER_ID_ATSCALE_INSTALLED} /bin/bash; \
	fi

# stop the running container
stop:
	@if [ -n "${CONTAINER_ID}" ]; then \
		docker stop ${CONTAINER_ID}; \
	else \
		docker stop ${CONTAINER_ID_ATSCALE_INSTALLED}; \
	fi

# tag the base image
tag:
	@if [ -z "${TAG}" ]; then \
		echo "'TAG' var missing, call like: 'make TAG=<tag> tag'"; \
	else \
		docker tag ${IMAGE_NAME} ${IMAGE_NAME}:${TAG}; \
	fi

# tag the atscale-installed image
tag-atscale-installed:
	@if [ -z "${TAG}" ]; then \
		echo "'TAG' var missing, call like: 'make TAG=<tag> tag'"; \
	else \
		docker tag ${IMAGE_NAME_ATSCALE_INSTALLED} ${IMAGE_NAME_ATSCALE_INSTALLED}:${TAG}; \
	fi

clean: clean-all

clean-all: clean-exited-containers clean-untagged-images

clean-exited-containers:
	docker rm $(shell docker ps -aq --no-trunc --filter status=exited) || true

clean-untagged-images:
	docker rmi $(shell docker images -f "dangling=true" -q) || true

debug:
	@echo "IMAGE_NAME_BASE: ${IMAGE_NAME_BASE}"
	@echo "IMAGE_NAME: ${IMAGE_NAME}"
	@echo "IMAGE_NAME_ATSCALE_INSTALLED: ${IMAGE_NAME_ATSCALE_INSTALLED}"
	@echo "CONTAINER_ID: ${CONTAINER_ID} (empty if base image container not running)"
	@echo "CONTAINER_ID_ATSCALE_INSTALLED: ${CONTAINER_ID_ATSCALE_INSTALLED} (empty if atscale-installed image container not running)"
	@echo "PORTS_TO_PUBLISH: ${PORTS_TO_PUBLISH}"
	@echo "HOSTS_TO_ADD: ${HOSTS_TO_ADD}"
	@echo "TAG: ${TAG}"
