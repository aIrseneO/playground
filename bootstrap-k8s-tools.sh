#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

VERSION=$1

echo -e "\n[Step 0] Dependencies"
apt-get update > /dev/null #2>&1
apt-get install -y apt-transport-https ca-certificates curl > /dev/null #2>&1
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg \
	https://packages.cloud.google.com/apt/doc/apt-key.gpg > /dev/null #2>&1
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] \
	https://apt.kubernetes.io/ kubernetes-xenial main" > \
	/etc/apt/sources.list.d/kubernetes.list
apt-get update > /dev/null #2>&1

# Get the tool(s) to install from the args 
isKubectl=0
i=2
while [[ "$i" -le "$#" ]]; do
	eval "X=\"\${$i}\""
	KUBE="$KUBE $X"
	KUBE_V="$KUBE_V $X=$VERSION"
	if [[ "$X" = "kubectl" ]]; then
		isKubectl=1;
	fi
	i=$((i + 1))
done

echo -e "\n[Step 1] Install $KUBE"
apt-get install -y $KUBE_V > /dev/null #2>&1
apt-mark hold $KUBE > /dev/null #2>&1

if [[ "$isKubectl" = "1" ]]; then
	echo -e "\n[Step 8] Activating bash-completion for kubectl"
	apt-get install -y bash-completion > /dev/null #2>&1
	sudo -H -u vagrant bash -c "source <(kubectl completion bash)"
	sudo -H -u vagrant bash -c \
		"echo \"source <(kubectl completion bash)\" >> /home/vagrant/.bashrc"
	source <(kubectl completion bash)
	echo "source <(kubectl completion bash)" >> $HOME/.bashrc
fi

# Reference(s)
#https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
