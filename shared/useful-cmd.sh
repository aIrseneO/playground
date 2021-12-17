#!/bin/bash

# K8S
kubectl get `kubectl api-resources | awk 'NR>1 {print $1}' \
	| tr [:space:] ',' | sed 's:.$::'` -A -o wide
