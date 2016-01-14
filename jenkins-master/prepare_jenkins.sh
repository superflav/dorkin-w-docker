#!/bin/bash

####
## Based on code from the comment thread in https://issues.jenkins-ci.org/browse/JENKINS-29239
####
set -e

if [[ "${JENKINS_HOME}" !=  "/var/jenkins_home" ]]; then
   mkdir -p $(dirname ${JENKINS_HOME})
   ln -sf -T /var/jenkins_home ${JENKINS_HOME}
fi

# create docker group if it doesn't exist, giving it the same group id as what
# has a handle on docker.sock
grep docker /etc/group || groupadd -g $(stat -c "%g" /var/run/docker.sock) -o docker
# add jenkins user to the docker group so it can access docker.sock
usermod -a -G docker jenkins
