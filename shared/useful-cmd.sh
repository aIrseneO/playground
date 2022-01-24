#!/bin/bash

# Docker
docker rmi -f $(docker images -f "dangling=true" -q)
# K8S
kubectl get `kubectl api-resources | awk 'NR>1 {print $1}' \
	| tr [:space:] ',' | sed 's:.$::'` -A -o wide


curl -k https://localhost:6443/livez?verbose
kubectl get --raw='/readyz?verbose'
curl -k 'https://localhost:6443/readyz?verbose&exclude=etcd'
