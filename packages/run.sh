#!/bin/bash

set -ex

## Install the required packages
export PACKAGES_ROOT_DIR=$(cd `dirname $0`/; pwd -P)

echo "Attempting to read all the packages under ${PACKAGES_ROOT_DIR}"

## Read through all the folders and attempt installing them
ls ${PACKAGES_ROOT_DIR}/ | while read package; do
  echo "Checking for an install script for ${package}"
  if [ -e "${package}/install.sh" ]; then
    echo "Attempting to install package - ${package}"

    # Run the install from within each package folder directly and not from PACKAGES_ROOT_DIR
    pushd ${package}
      bash install.sh
    popd

    echo "${package} installation completed"
  fi
done

# Making sure the /go-agent is owned by go user
chown -R go:go /go-agent/
