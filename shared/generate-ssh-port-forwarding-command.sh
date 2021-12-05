#! /bin/bash

################################################################################
##     Copyright (c) 2020 Arsene Temfack                                      ##
##                                                                            ##
##     SPDX-License-Identifier: MIT                                           ##
################################################################################

APIPort=6443
MasterHostIP=$1
WorkerHostIP=$2
WorkerHostUser=$3
MasterIP=$4
WorkerInterface=eth1
SSH_CONFIG=/home/vagrant/.ssh/config

# To be run in a worker node after the connection has been started with the
#	script `start-K8s-apiserver-port-forwarding.sh`

MSG="Create an encrypted SSH connection between a Worker Node (VM) and the \n
host machine of the Master Node through which API server port can be relayed.\n
\nUsage: $0 [ [--help | -h | help] | \n
\t<Master Host IP> <Worker Host IP> <Worker Host User> <Master IP> ]\n\n
\tMaster Host IP: \tIP of the Host of the Master Node (VM) in the LAN\n
\tWorker Host IP: \tIP of the Host of the Worker Node (VM) in the LAN\n
\tWorker Host User:\tUser in the Host of the Worker Node (VM) in the LAN\n
\tMaster IP: \t\tIP address of the Master Node (VM)\n\n
Example: $0 192.168.0.10 192.168.0.11 userk8s 192.168.84.10\n
output:\n
\tssh -F $SSH_CONFIG userk8s@192.168.0.11 -N -f -L \
192.168.84.10:$APIPort:192.168.0.10:$APIPort" 

if [[ "$#" = "1" ]] &&
		[[ "$1" = "--help" || "$1" = "-h" || "$1" = "help" ]]; then
	echo -e $MSG; exit 0
fi

if [[ "$#" != "4" ]]; then
	echo -e $MSG; exit 1
fi

ip addr add $MasterIP/32 dev $WorkerInterface 2> /dev/null

# $User is the user of the host of the master node on wich apiserver is connected
echo "ssh -F $SSH_CONFIG $WorkerHostUser@$WorkerHostIP -N -f -L \
$MasterIP:$APIPort:$MasterHostIP:$APIPort"
