#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

MASTER_IP=$1
K8S_VERSION=$2
K8S_VERSION=${K8S_VERSION%-*}
CALICO_VERSION=$3
CIDR=$4

echo -e "\n[Step 0] Bootstraping Master node"

echo -e "\n[Step 1] Pulling container required by kubeadm"
kubeadm config images pull #> /dev/null #2>&1

echo -e "\n[Step 2] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=$CIDR \
	--kubernetes-version=$K8S_VERSION --upload-certs > kubeadm-init.out

echo -e "\n[Step 3] allow vagrant user"
mkdir -p /home/vagrant/.kube #> /dev/null #2>&1
cp /etc/kubernetes/admin.conf /home/vagrant/.kube/config #> /dev/null #2>&1
chown -R vagrant:vagrant /home/vagrant/.kube #> /dev/null #2>&1

echo -e "\n[Step 4] allow root user"
mkdir -p /root/.kube #> /dev/null #2>&1
cp /etc/kubernetes/admin.conf /root/.kube/config #> /dev/null #2>&1

echo -e "\n[Step 5] Deploy Calico network"
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f \
	https://docs.projectcalico.org/$CALICO_VERSION/manifests/calico.yaml

# Reference:
#wget https://docs.projectcalico.org/manifests/calico.yaml
