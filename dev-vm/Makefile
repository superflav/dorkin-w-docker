CONTAINER_NAME := $(shell docker ps | grep "dev-vm_prototype" | awk '{print $$1}')

all: build

build:
	docker build -t dev-vm_prototype .

run:
	docker run -it dev-vm_prototype /bin/bash

run-daemon:
	docker run -d dev-vm_prototype

ssh:
	docker exec -it $(CONTAINER_NAME) /bin/bash

stop:
	docker stop $(CONTAINER_NAME)

clean-all: clean-stopped-containers clean-untagged-images

clean-stopped-containers:
	docker rm $(shell docker ps -aq --no-trunc) || true

clean-untagged-images:
	docker rmi $(shell docker images | grep "^<none>" | awk '{print $$3}') || true
