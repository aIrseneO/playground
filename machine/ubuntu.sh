#!/bin/bash
echo -e "\
alias vagrant='\
NAME=ubuntu \
IMAGE=generic/ubuntu1804 \
TAG=3.6.4 \
NETWORK=private \
IP=192.168.42.10 \
HOSTNAME=ubuntu \
PROVIDER=virtualbox \
CPU=1 \
MEMORY=1024 \
vagrant'"