#!/bin/bash

## Copy the secret (gradle.properties) to it's location
if [ -n ${GRADLE_SECRETS_MOUNT_DIR} ]; then
  # if this environment variable is found, copy the gradle.properties from this location to /home/go/.gradle/gradle.properties
  cp ${GRADLE_SECRETS_MOUNT_DIR}/gradle.properties /home/go/.gradle/gradle.properties
fi
