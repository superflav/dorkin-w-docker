# Running dev-vm in Docker


## Set up Docker

### OS X

#### Install Docker

Ths simplest way to get going with running dev-vm on OS X is to just install
the Docker Toolbox:

https://www.docker.com/products/docker-toolbox

For more in-depth details on running Docker on OS X, see the full docs:

https://docs.docker.com/mac/

#### Set up Docker Engine and configure environment

On OS X the Docker Engine runs inside a VM, which is managed by Docker Machine.
Open a terminal window and run the following to:

1. Create a `dev` machine
2. Configure the terminal's environment for Docker
3. Register the `dev` machine's ip address in /etc/hosts as `docker.local`


    source ./bin/update-docker-host.sh

Sourcing this file is idempotent, and you will need to run it in each OS X
terminal window that you want configured to work with Docker. This can be done
manually or add is as a line to your `~/.profile` or equivalent.

### Linux

#### Install Docker

https://docs.docker.com/linux/

#### Configure environment

In keeping consistent w/running dev-vm on OS, this registers 127.0.0.1 in
/etc/hosts as `docker.local`. Only need to be run if you want to access dev-vm
via `docker.local` rather than `localhost`.

    source ./bin/update-docker-host.sh


## Make all the things

The `Makefile` in this directory wraps most of the common commands that are
needed in order build & run a standalone Hadoop cluster w/AtScale installed.

Most of the make targets require that the `OS` param is set. `OS` is used to
specify the operating system against which the make target will be run. The
currently supported operating systems are `centos6` and `ubuntu14.04`, both of
which have implementation details contained within their respectively named
sub-directory.

### Build image

    make OS=<operating_system> build

### Run container & drop into shell from built image

    make OS=<operating_system> run

### SSH into running container

    make OS=<operating_system> ssh

### Print out Makefile debugging info

    make OS=<operating_system> debug

### Other useful make commands

#### Run container in detached (daemon) mode from built image

    make OS=<operating_system> run-daemon

#### Stop running container

    make OS=<operating_system> stop

#### Clean exited containers & untagged images

    make OS=<operating_system> clean


## Build & run a standalone Hadoop cluster w/AtScale installed

OK, so Docker is set up and you've seen a bunch of the make commands. Now let's
put them to use and spin up a dev-vm instance. For this example, we'll be using
`OS=centos6`, but feel free to use any of the supported OSes.

### Build the image

AtScale doesn't yet have a private Docker registry, so you're going to have to build images yourself for now. This will take ~10-15 minutes when in the office, and much longer when VPNed in.

    make OS=centos6 build




### Run container & drop into shell from built image

    make OS=centos6 run

### SSH into the container


### Point your browser at some things

http://docker.local:10500


### Run `query-tester` tests

Pull down the latest: https://github.com/AtScaleInc/query-tester

And then run:

    sbt "run -g smoke --host docker.local"


### Upload a new installer




----


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



## Dockered Hadoop

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html

NameNode - http://localhost:50070/
ResourceManager - http://localhost:8088/
