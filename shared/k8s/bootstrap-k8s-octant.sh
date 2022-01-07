#!/bin/bash

IMAGE=airseneo/octant:latest
PORT=88

kubectl create ns octant
kubectl create configmap octant-config --from-file ~/.kube/config -n octant

echo -e "apiVersion: v1
kind: Service
metadata:
  name: octant-service
  labels:
    run: octant
spec:
  type: LoadBalancer
  ports:
  - port: $PORT
    targetPort: $PORT
    protocol: TCP
    name: http
  selector:
    run: octant
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: octant-deployment
spec:
  selector:
    matchLabels:
      run: octant
  replicas: 1
  template:
    metadata:
      labels:
        run : octant
    spec:
      containers:
      - name: octant
        image: $IMAGE
        imagePullPolicy: Always
        volumeMounts:
        - name: config
          mountPath: /.kube
        ports:
        - containerPort: $PORT
      volumes:
        - name: config
          configMap:
            name: octant-config" | kubectl -n octant create -f -


# Dockerfile:
#	FROM alpine:3.12
#	RUN apk add --no-cache curl
#	WORKDIR /tmp/plug
#	RUN mkdir -p  /root/.config/octant/plugins
#	RUN curl -L https://github.com/jenkins-x/octant-jx/releases/download/v0.0.27/octant-jx-linux-amd64.tar.gz | tar xzv
#	RUN mv octant-* /root/.config/octant/plugins
#	WORKDIR /tmp/oct
#	RUN curl -L https://github.com/vmware-tanzu/octant/releases/download/v0.16.1/octant_0.16.1_Linux-64bit.tar.gz | tar xzv
#	RUN mv ./octant_0.16.1_Linux-64bit/octant /root/
#	WORKDIR /root
#	EXPOSE 88
#	CMD OCTANT_LISTENER_ADDR=0.0.0.0:88 ./octant --kubeconfig /.kube/config --disable-open-browser

# Reference:
#	https://007ba7.us/howto/octant/
