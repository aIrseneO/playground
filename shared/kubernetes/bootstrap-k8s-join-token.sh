#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[-- Generate Token --] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /home/vagrant/joincluster.sh
chown $(id -u):$(id -g) /home/vagrant/joincluster.sh

# Reference:
#	https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#join-nodes
