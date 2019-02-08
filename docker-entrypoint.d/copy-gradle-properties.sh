#!/bin/bash

## Copy the secret (gradle.properties) to it's location
if [ -n ${GRADLE_SECRETS_MOUNT_DIR} ]; then
  echo "Copying ${GRADLE_SECRETS_MOUNT_DIR}/gradle.properties to /home/go/.gradle"
  # if this environment variable is found, copy the gradle.properties from this location to /home/go/.gradle/gradle.properties
  cp ${GRADLE_SECRETS_MOUNT_DIR}/gradle.properties /home/go/.gradle/gradle.properties
  chown -R go:go /home/go/.gradle/
  echo "Copy complete for ${GRADLE_SECRETS_MOUNT_DIR}/gradle.properties to /home/go/.gradle"
fi
