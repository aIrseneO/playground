#!/bin/bash

helm repo add jenkins https://charts.jenkins.io

helm install jenkins jenkins/jenkins --namespace jenkins \
	--create-namespace --values=jenkins-values.yaml

# Reference:
	#https://artifacthub.io/packages/helm/jenkinsci/jenkins
