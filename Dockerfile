FROM gocd/gocd-agent-ubuntu-16.04:18.11.0

ENV GRADLE_VERSION 2.6

# Install JDK8
RUN add-apt-repository ppa:webupd8team/java && \
	apt-get update && \
	apt-get install -y oracle-java8-installer curl unzip maven wget

# Install Grade Distribution
RUN mkdir -p /opt/gradle && \
	curl "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip" > /tmp/gradle-${GRADLE_VERSION}-all.zip && \
	unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-all.zip && \
	rm -f /tmp/gradle-${GRADLE_VERSION}-all.zip

