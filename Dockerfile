FROM gocd/gocd-agent-ubuntu-16.04:v18.11.0

ENV GRADLE_VERSION 2.6
ENV JAVA_HOME  /usr/lib/jvm/java-11-openjdk-amd64/

# Install JDK8
RUN apt-get update && \
        apt-get install -y software-properties-common && \
        apt-get install -y openjdk-8-jdk curl unzip maven wget

# Install Grade Distribution
RUN mkdir -p /opt/gradle && \
        curl -L -v "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip" > /tmp/gradle-${GRADLE_VERSION}-all.zip && \
        unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-all.zip && \
        rm -f /tmp/gradle-${GRADLE_VERSION}-all.zip

