# Running dev-vm in Docker

## Set up Docker (OS X only for now)

### Install Docker Toolbox

https://www.docker.com/products/docker-toolbox

### Install VirtualBox

https://www.virtualbox.org/

### Use docker-machine to create `dev` VM

Run the following command to create a Virtualbox VM in which the Docker daemon will run.

    docker-machine create -d virtualbox --virtualbox-memory=6144 --virtualbox-cpu-count=4 dev

### Update your env to use Docker

You'll need to run this in every terminal window that you're Dockering from, which can be a pain, so you can alternatively add it to your `~/.profile`

    ./bin/update-docker-host.sh

### Useful docker-machine commands

    # List Docker VMs (machines)
    docker-machine ls

    # Display the commands to set up the environment for the Docker client
    docker-machine env dev

    # Configure your shell to use `dev` VM for Docker
    eval $(docker-machine env dev)

    # Stop the Docker `dev` VM
    docker-machine stop dev

    # Remove the Docker `dev` VM
    docker-machine rm dev

    # Display docker-machine help
    docker-machine help

## Build & run a standalone Hadoop cluster w/AtScale installed

The `Makefile` in this directory wraps most of the common commands that are needed in order build & run a standalone Hadoop cluster w/AtScale installed.

Many of the make targets require that the `OS` param is set. `OS` is used to specify the operating system against which the make target will be run. The currently supported operating systems are `centos6` and `ubuntu14.04`, both of which have implementation details contained within their respectively named sub-directory.

#### Build image

    make OS=<operating_system>

#### Run container from built image

    make OS=<operating_system> run

#### ssh into running container

    make OS=<operating_system> ssh

#### Stop running container

    make OS=<operating_system> stop

#### Print out useful Makefile debugging info

    make OS=<operating_system> debug

## Run `query-tester` tests

Pull down the latest: https://github.com/AtScaleInc/query-tester

And then run:

    sbt "run -g smoke --host docker.local"



## Dockered Hadoop

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html


NameNode - http://localhost:50070/
ResourceManager - http://localhost:8088/


## TODO

* http://cavaliercoder.com/blog/update-etc-hosts-for-docker-machine.html
* https://github.com/bamarni/docker-machine-dns
