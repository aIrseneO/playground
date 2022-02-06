#!/bin/bash
echo -e "\
alias vagrant='\
NAME=centos \
IMAGE=generic/centos8 \
TAG=3.6.4 \
NETWORK=private \
IP=192.168.42.11 \
HOSTNAME=centos \
PROVIDER=virtualbox \
CPU=1 \
MEMORY=1024 \
vagrant'"
