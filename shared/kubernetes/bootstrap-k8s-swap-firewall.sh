#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[-- Update --] Updating"
apt-get update > /dev/null #2>&1

echo -e "\n[-- Swap/Firewal --] Setting Swap off and deactivating ufw"
swapoff -a > /dev/null #2>&1
sed -i "/swap/d" /etc/fstab > /dev/null #2>&1
systemctl disable --now ufw > /dev/null #2>&1

# References:
#	https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#before-you-begin
