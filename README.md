# dorkin-w-docker

Playing around w/Docker.

### Learn
* Riot Games eng blog: http://engineering.riotgames.com/
* Docker in Docker: https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/


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

#### Remove all containers
    docker rm $(docker ps -aq --no-trunc)


### TODO
* Script config of docker location using init groovy script. https://mriet.wordpress.com/2011/06/23/groovy-jenkins-system-script/
