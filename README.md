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
$ vagrant up master10
$ vagrant up worker100
```
To have a the worker node join the master node run:
```bash
$ vagrant provision master --provision-with generateJoinCommand
$ MASTER=master10 vagrant provision worker100 --provision-with joinMasterNode
```
The `Vagrantfile` is designed to be highly configurable and self-explanatory, check it out for more.