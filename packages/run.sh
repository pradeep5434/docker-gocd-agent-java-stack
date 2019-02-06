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
    bash ${package}/install.sh
    echo "${package} installation completed"
  fi
done
