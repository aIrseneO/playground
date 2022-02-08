#!/bin/bash

apt-get install -f nfs-kernel-server nfs-common -y
mkdir -p /srv/nfs/kubedata
echo "/srv/nfs/kubedata *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)" \
	> /etc/exports
systemctl restart nfs-kernel-server.service

helm repo add nfs-subdir-external-provisioner \
		 https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install my-nfs-provisioner \
	nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
	--set nfs.server=192.168.0.100 --set nfs.path=/srv/nfs/kubedata \
	--set storageClass.defaultClass=true

# https://artifacthub.io/packages/helm/nfs-subdir-external-provisioner/nfs-subdir-external-provisioner
