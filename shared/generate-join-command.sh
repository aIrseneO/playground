#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[Step 0] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /home/vagrant/joincluster.sh
chown $(id -u):$(id -g) /home/vagrant/joincluster.sh
