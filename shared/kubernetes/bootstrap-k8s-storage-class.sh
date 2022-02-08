#!/bin/bash

NFSServerIP=$NFS

kubectl create ns nfs
kubectl -n nfs create -f /vagrant/k8s/storage-class/rbac.yaml
kubectl -n nfs create -f /vagrant/k8s/storage-class/default-sc.yaml
sed "s:NFSServerIP:$NFSServerIP:g" /vagrant/k8s/storage-class/deployment.yaml \
	| kubectl create -n nfs -f -

# Reference:
#	https://007ba7.us/howto/nfs-storage/
