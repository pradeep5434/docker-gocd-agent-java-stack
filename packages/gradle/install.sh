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

cat "${CWD}/versions_to_cache.txt" | while read LINE; do
  GRADLE_VERSION_TO_CACHE=$(echo $LINE | cut -f1 -d,)
  GRADLE_DISTRIBUTION_TYPE=$(echo $LINE | cut -f2 -d,)
  echo "Installing Version=${GRADLE_VERSION_TO_CACHE} with type as ${GRADLE_DISTRIBUTION_TYPE}"

  TEMP_DIR="/tmp/gradle-setup-${GRADLE_VERSION_TO_CACHE}-${GRADLE_DISTRIBUTION_TYPE}"
  mkdir -p ${TEMP_DIR}
  pushd ${TEMP_DIR}
    /opt/gradle/gradle-${GRADLE_VERSION}/bin/gradle wrapper --gradle-version ${GRADLE_VERSION_TO_CACHE} --distribution-type ${GRADLE_DISTRIBUTION_TYPE}
    sed -ie 's/https/http/g' gradle/wrapper/gradle-wrapper.properties
    ./gradlew
  popd
  rm -rf ${TEMP_DIR}

  echo "Cached the --gradle-version ${GRADLE_VERSION_TO_CACHE} with --distribution-type ${GRADLE_DISTRIBUTION_TYPE}"
done

# Move all the cached versions to go user at one shot instead of multiple times
cp -R /root/.gradle /home/go/
chown -R go:go /home/go/
