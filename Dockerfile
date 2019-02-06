FROM gocd/gocd-agent-ubuntu-16.04:v18.11.0

ENV GRADLE_VERSION 5.2
ENV JAVA_HOME  /usr/lib/jvm/java-8-openjdk-amd64/

WORKDIR /goagent-setup

# Add all the required package scripts to the docker
ADD packages /goagent-setup
ADD docker-entrypoint.d /docker-entrypoint.d/

RUN /goagent-setup/run.sh