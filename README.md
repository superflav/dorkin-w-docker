# dorkin-w-docker

Playing around w/Docker.

### Learn
* Riot Games eng blog: http://engineering.riotgames.com/
* Docker in Docker: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/
  * Issue in official Jenkins CI container: http://stackoverflow.com/questions/22135897/access-docker-socket-within-container
    * > docker exec -u root XXXX /bin/chmod a+s /usr/local/bin/docker
    * **note** solved above with prepare_jenkins.sh script
  * Fail to start containers: http://stackoverflow.com/questions/33399288/cloudbees-jenkins-plugin-fails-to-start-containers
    * Needs to support volumes-from

### Setup Jenkins

#### get ip address of docker-machine
    docker-machine env dev

#### spin up jenkins cluster
    docker-compose up -d

#### point your browser at ip address
#### upload docker-custom-build-environment plugin
#### create new job
#### configure docker
* add jenkins_data data volume container
* check "xxx" box
* save
#### run job
#### done


### Commands for this project

#### Docker Machine
    docker-machine ls
    docker-machine create --driver virtualbox dev
    docker-machine env dev
    eval "$(docker-machine env dev)"

#### Docker
    docker run --name=jenkins-data myjenkinsdata
    docker run -p 50000:50000 --name=jenkins-master --volumes-from=jenkins-data -d myjenkins
    docker run -p 80:80 --name=jenkins-nginx --link jenkins-master:jenkins-master -d myjenkinsnginx

#### Docker compose
    docker-compose stop
    docker-compose rm
    docker-compose build
    docker-compose up -d


### Useful Docker commands
https://github.com/wsargent/docker-cheat-sheet

#### Remove dangling docker volumes:
    docker volume rm $(docker volume ls -qf dangling=true)

#### Remove all stopped containers
    docker rm $(docker ps -aq --no-trunc)

#### Remove all untagged images
    docker rmi $(docker images | grep "^<none>" | awk '{print $3}')

#### Open bash session in container
    docker exec -i -t CONTAINER_NAME /bin/bash


### TODO
* Script config of docker location using init groovy script. https://mriet.wordpress.com/2011/06/23/groovy-jenkins-system-script/



============================
https://hub.docker.com/r/cloudera/impala-dev/

docker run -i -t cloudera/impala-dev:minimal /bin/bash
> cd Impala
> git pull
> source bin/impala-config.sh
> ./buildall.sh -skiptests -build_shared_libs -release
