#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

NAME=calico
VERSION=$1

echo -e "\n[-- CNI --] Deploy Calico network"

#kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f \
#	https://docs.projectcalico.org/$CALICO_VERSION/manifests/calico.yaml

kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f \
	https://docs.projectcalico.org/$VERSION/manifests/tigera-operator.yaml
kubectl --kubeconfig=/etc/kubernetes/admin.conf create -f \
	https://docs.projectcalico.org/$VERSION/manifests/custom-resources.yaml

# Reference:
#	https://projectcalico.docs.tigera.io/getting-started/kubernetes/quickstart
