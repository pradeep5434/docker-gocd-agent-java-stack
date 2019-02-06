#!/bin/bash

set -ex

## Install the cloudfoundary CLI
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
ln -s /usr/local/bin/cf /usr/bin/cf
