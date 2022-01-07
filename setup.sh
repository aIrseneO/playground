#!/bin/bash

#vagrant up master100

#vagrant up worker110

vagrant provision master100 --provision-with generateJoinCommand
MASTER=master100 vagrant provision worker110 --provision-with joinMasterNode

vagrant provision master100 --provision-with myconf

vagrant provision master100 --provision-with helm

IP=192.168.0.100/32 vagrant provision master100 --provision-with metalLB

NFS=192.168.0.99 vagrant provision master100 --provision-with nfsStorage

vagrant provision master100 --provision-with octant
