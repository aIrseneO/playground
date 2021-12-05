#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[Step 0] bootstrap minikube"
apt-get update > /dev/null #2>&1
curl -LO \
	https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
install minikube-linux-amd64 /usr/local/bin/minikube
usermod -aG docker vagrant && newgrp docker
sudo -H -u vagrant bash -c 'minikube start --driver=docker > /dev/null 2>&1'

# Reference:
#https://minikube.sigs.k8s.io/docs/start/
