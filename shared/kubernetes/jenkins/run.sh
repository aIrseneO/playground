#!/bin/bash

helm repo add jenkins https://charts.jenkins.io

helm install jenkins jenkins/jenkins --namespace jenkins \
	--values=jenkins-values.yml

# Reference:
	#https://artifacthub.io/packages/helm/jenkinsci/jenkins
