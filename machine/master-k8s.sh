#!/bin/bash
echo -e "\
alias vagrant='\
NAME=mastrer \
IMAGE=generic/ubuntu1804 \
TAG=3.6.4 \
NETWORK=public \
IP=192.168.0.100 \
HOSTNAME=master \
PROVIDER=virtualbox \
CPU=3 \
MEMORY=3072 \
vagrant'"
