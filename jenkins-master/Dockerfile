FROM jenkins:1.625.3
MAINTAINER Chris Fraser

USER root

# Crete Jenkins log dir & cache dir (to hold exploded war)
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins
# grab gosu for easy step-down from root
RUN curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/1.7/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu

# install jenkins plugins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# COPY configure.groovy /usr/share/jenkins/ref/init.groovy.d/configure.groovy

# Set default options
ENV JAVA_OPTS="-Xmx2048m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"

# override ENTRYPOINT so we can run the prepare_jenkins.sh script at boot
COPY prepare_jenkins.sh /usr/local/bin/prepare_jenkins.sh
ENTRYPOINT /usr/local/bin/prepare_jenkins.sh \
  && HOME=$JENKINS_HOME gosu jenkins /bin/tini -- /usr/local/bin/jenkins.sh
