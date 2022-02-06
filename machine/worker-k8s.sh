#!/bin/bash
echo -e "\
alias vagrant='\
NAME=worker \
IMAGE=generic/ubuntu1804 \
TAG=3.6.4 \
NETWORK=public \
IP=192.168.0.110 \
HOSTNAME=worker \
PROVIDER=virtualbox \
CPU=2 \
MEMORY=2048 \
vagrant'"
