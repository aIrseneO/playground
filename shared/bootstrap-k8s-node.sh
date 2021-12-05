#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[Step 0] Updating"
apt-get update > /dev/null #2>&1

echo -e "\n[Step 1] Letting iptables see bridged traffic"
cat <<EOF > /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sysctl --system #> /dev/null #2>&1

echo -e "\n[Step 2] Setting Swap off and deactivating ufw"
swapoff -a > /dev/null #2>&1
sed -i "/swap/d" /etc/fstab > /dev/null #2>&1
systemctl disable --now ufw > /dev/null #2>&1

echo -e "\n[Step 3] Settng up the container runtime"
mkdir /etc/docker > /dev/null #2>&1
cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
systemctl enable docker > /dev/null #2>&1
systemctl daemon-reload > /dev/null #2>&1
systemctl restart docker > /dev/null #2>&1
#https://kubernetes.io/docs/setup/production-environment/container-runtimes/

#PASSWORD=password
#echo -e "\n[Step 4] Setting root password and permit root login via ssh"
#echo -e "$PASSWORD\n$PASSWORD" | passwd root > /dev/null 2>&1
#sed -i 's/^PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
#echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
#systemctl reload sshd

# References
#https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
