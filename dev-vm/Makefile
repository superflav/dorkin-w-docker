# construct the name under which to run the container
CONTAINER_NAME := $(shell echo $${PWD\#\#*/})
# get the id of the container that's running this image
CONTAINER_ID := $(shell docker ps | grep "${CONTAINER_NAME}" | awk '{print $$1}')

PORTS_TO_PUBLISH := -p 10500-10520:10500-10520 -p 11111-11199:11111-11199 -p 8088:8088 -p 50070:50070

all: build

build:
	docker build -t ${CONTAINER_NAME} .

blah:
	echo "${CONTAINER_NAME} ${CONTAINER_ID} ${PORTS_TO_PUBLISH}"

run:
	# docker run -it --name ${CONTAINER_NAME} -p 50070:50070 -p 8088:8088 ${CONTAINER_NAME} /bin/bash
	docker run -it ${PORTS_TO_PUBLISH} ${CONTAINER_NAME} /bin/bash

run-daemon:
	docker run -d --name ${CONTAINER_NAME} ${PORTS_TO_PUBLISH} ${CONTAINER_NAME}

ssh:
	docker exec -it ${CONTAINER_ID} /bin/bash

stop:
	docker stop ${CONTAINER_ID}

clean-all: clean-stopped-containers clean-untagged-images

clean-stopped-containers:
	docker rm $(shell docker ps -aq --no-trunc --filter status=exited) || true

clean-untagged-images:
	docker rmi $(shell docker images -f "dangling=true" -q) || true
