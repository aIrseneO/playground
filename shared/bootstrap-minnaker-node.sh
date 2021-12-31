#!/bin/bash

NAME=minniker
VERSION=v0.1.3

IP_ADDRESS=$1

curl -L https://github.com/armory/minnaker/archive/$VERSION.tar.gz | tar -zxv
cd minnaker-0.1.*
./scripts/install.sh -o -P $IP_ADDRESS

#REFERENCE:
# https://github.com/armory/minnaker
