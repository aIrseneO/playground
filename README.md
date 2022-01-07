# Playgrounds
This repository contains a set of virtual machines useful for exploring Linux distributions and playing with some DevOps tools.
> ## General
Check included VMs:
```bash
$ vagrant status
```
> ## Kubernetes Playground

Before starting the cluster, check [kubernetes web site](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#before-you-begin) for recommandations.

The resources are requested in the `Vagrantfile`, update if needed.
>> ### Create a cluster:
Spin up two Nodes, one master and one worker:
```bash
$ vagrant up master100
$ vagrant up worker110
```
To have a the worker node join the master node run:
```bash
$ vagrant provision master --provision-with generateJoinCommand
$ MASTER=master100 vagrant provision worker110 --provision-with joinMasterNode
```

Others:
- To configure a default storage class from a NFS server:
	```bash

	```
- To configure a default storage class from a NFS server:
	```bash
	
	```
The `Vagrantfile` is designed to be highly configurable and self-explanatory, check it out for more.