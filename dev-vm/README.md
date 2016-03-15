# Running dev-vm in Docker


## Set up Docker

### OS X

#### Install Docker

Ths simplest way to get going with running dev-vm on OS X is to just install
the Docker Toolbox.

https://www.docker.com/products/docker-toolbox

For more in-depth details on running Docker on OS X, see the full docs.

https://docs.docker.com/mac/

#### Set up Docker Engine and configure environment

On OS X the Docker Engine runs inside a VM, which is managed by Docker Machine.
Open a terminal window and run the following, which will:

1. Create a `dev` machine
2. Configure the terminal's environment for Docker
3. Register the `dev` machine's ip address in /etc/hosts as `docker.local`


    source ./bin/update-docker-host.sh

You will need to source this file in each OS X terminal window that you want
configured to work with Docker. This can be done manually or added as a line
to your `~/.profile` or equivalent.

### Linux

#### Install Docker

https://docs.docker.com/linux/

#### Configure environment

In keeping consistent w/running dev-vm on OS X, `update-docker-host.sh`
registers 127.0.0.1 in /etc/hosts as `docker.local`. This only needs to be run
if you want to access dev-vm via `docker.local` rather than `localhost`.

    source ./bin/update-docker-host.sh


## Make all the things

The `Makefile` in this directory wraps most of the common commands that are
needed in order build & run a standalone Hadoop cluster with AtScale installed.

Most of the make targets require that the `OS` param to be set. `OS` is used to
specify the operating system against which the make target will be run. The
currently supported operating systems are `centos6` and `ubuntu14.04`, both of
which have implementation details contained within their respectively named
sub-directory.

Here are a bunch of the supported make commands. For step-by-step instructions
on how to put these to use, see the following section below.

### Build the image

    make OS=<operating_system> build

### Run container from built image & drop into shell

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
put them to use and spin up a dev-vm instance. What's currently supported is
single node Hadoop cluster, but plans are to build out real multi-container
clusters with master, data & gateway nodes in the future.

For this example, we'll be using `OS=centos6`, but feel free to use any of the
supported OSes.

### Build the image

AtScale doesn't yet have a private Docker registry, so you're going to have to
build images yourself for now. This will take ~10-15 minutes when in the office,
and much longer when VPNed in.

    make OS=centos6 build

### Run container from built image & drop into shell

Once the image is built, you can run the following command to spin up a
container. All of the Hadoop components are already installed in the image, so
the bulk of the time spent bringing the container up is primarily in the
installation of AtScale. An AtScale pre-install pass is in the works, which
should cut the amount of time by 50% or more, but for now this will also take
in the 10-15 minute range.

Once the container is spun up, this command will drop you into an interactive
console as the `root` user on the running container. Note that when you exit
out of this particular console, you will take the container with you and it
will shut down as well. To avoid this, you can run the container in detached
mode via the `run-daemon` target.

    make OS=centos6 run

### SSH into the container

Do the following to ssh into the running container as the `atscale` user.
This console is safe to exit out of, and will not take down the container when
doing so.

    make OS=centos6 ssh

You can also ssh in as `root` by doing:

    make OS=centos6 SSH_USER=root ssh

### Point your browser at some things

* AtScale: http://docker.local:10500
* NameNode: http://docker.local:50070
* ResourceManager: http://docker.local:8088

### Run `query-tester` tests

Pull down the latest: https://github.com/AtScaleInc/query-tester

And then run:

    sbt "run -g smoke --host docker.local"

### Upload files to a running container

To upload files to a running container, use Docker's `cp` command.

You'll need the id or name of the container that you're uploading to, and you
can get the list of running containers by doing:

    docker ps

Now that you have the <CONTAINER>, you can:

    docker cp <SRC_PATH> <CONTAINER>:<DEST_PATH>

----
## Other resources

### Useful docker-machine commands

More can be found at https://docs.docker.com/machine/, but, for reference,
these are some of the more commonly used docker-machine commands.

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

### Hadoop

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html
