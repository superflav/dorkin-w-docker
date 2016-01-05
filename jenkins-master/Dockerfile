FROM jenkins:1.625.3
MAINTAINER Chris Fraser

# Crete Jenkins log dir & cache dir (to hold exploded war)
USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# COPY configure.groovy /usr/share/jenkins/ref/init.groovy.d/configure.groovy

# Set default options
ENV JAVA_OPTS="-Xmx2048m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"
