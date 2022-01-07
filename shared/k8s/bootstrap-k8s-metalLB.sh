#!/bin/bash

NAME=MetalLB
VERSION="v0.11.0"

IP_RANGE=$IP

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/$VERSION/manifests/metallb.yaml

kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

echo -e "apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $IP_RANGE" | kubectl apply -f -

# Reference
#	https://metallb.universe.tf/installation/#installation-by-manifest
#	https://github.com/metallb/metallb
