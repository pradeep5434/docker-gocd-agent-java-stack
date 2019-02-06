#!/bin/bash

set -ex

export CWD=$(cd `dirname $0`/; pwd -P)

## Download and cache different versions of gradle locally

## Master Gradle Version
export GRADLE_VERSION=${GRADLE_VERSION:-5.2}

# Install Master Grade Distribution
mkdir -p /opt/gradle
curl -L -v "https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip" > /tmp/gradle-${GRADLE_VERSION}-all.zip
unzip -d /opt/gradle /tmp/gradle-${GRADLE_VERSION}-all.zip
rm -f /tmp/gradle-${GRADLE_VERSION}-all.zip

# Cache a Gradle distribution locally
function cache_gradle_version {
  GRADLE_VERSION_TO_CACHE=$1
  GRADLE_DISTRIBUTION_TYPE=${2:-"all"}
  
  mkdir -p /tmp/gradle-setup
  cd /tmp/gradle-setup
  /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper --gradle-version ${GRADLE_VERSION_TO_CACHE} --distribution-type ${GRADLE_DISTRIBUTION_TYPE}
  sed -ie 's/https/http/g' gradle/wrapper/gradle-wrapper.properties
  ./gradlew
  rm -rf /tmp/gradle-setup
}

cat "${CWD}/versions_to_cache.txt" | while read line; do
  GRADLE_VERSION_TO_CACHE=$(echo $line | cut -f1 -d,)
  GRADLE_DISTRIBUTION_TYPE=$(echo $line | cut -f2 -d,)
  echo "Installing Version=${GRADLE_VERSION_TO_CACHE} with type as ${GRADLE_DISTRIBUTION_TYPE}"
  cache_gradle_version ${GRADLE_VERSION_TO_CACHE} ${GRADLE_DISTRIBUTION_TYPE}
  echo "Cached the --gradle-version ${GRADLE_VERSION_TO_CACHE} with --distribution-type ${GRADLE_DISTRIBUTION_TYPE}"
done

# Move all the cached versions to go user at one shot instead of multiple times
cp -R /root/.gradle /home/go/
chown -R go:go /home/go/
