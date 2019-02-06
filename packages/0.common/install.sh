#!/bin/bash

set -ex

apt-get update
apt-get install -y software-properties-common
apt-get install -y curl unzip wget
apt-get autoclean