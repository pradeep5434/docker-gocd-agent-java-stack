FROM gocd/gocd-agent-ubuntu-16.04:v18.11.0

ENV GRADLE_VERSION 2.6
ENV JAVA_HOME  /usr/lib/jvm/java-8-openjdk-amd64/

# Install JDK8
RUN apt-get update && \
        apt-get install -y software-properties-common && \
        apt-get install -y openjdk-8-jdk curl unzip maven wget

# Install Grade Distribution
RUN mkdir -p /opt/gradle && \
        curl -L -v "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip" > /tmp/gradle-${GRADLE_VERSION}-all.zip && \
        unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-all.zip && \
        rm -f /tmp/gradle-${GRADLE_VERSION}-all.zip
	
# Cache Gradle distribution locally
RUN mkdir -p /tmp/gradle-setup && \
		cd /tmp/gradle-setup && \
		/opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper --distribution-type all && \
		sed -ie 's/https/http/g' gradle/wrapper/gradle-wrapper.properties && \
		./gradlew  && \
		cp -R /root/.gradle /home/go/ && \
		chown -R go:go /home/go/ && \
		rm -rf /tmp/gradle-setup
