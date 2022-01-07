#! /bin/bash

################################################################################
##     Copyright (c) 2020 Arsene Temfack                                      ##
##                                                                            ##
##     SPDX-License-Identifier: MIT                                           ##
################################################################################

APIPort=6443
MasterHostIP=$1
MasterIP=$2
MasterUser=vagrant
MasterPassword=vagrant
SSH_CONFIG=shared/ssh_config

# To be run in the Host of a Master Node (VM)

MSG="Create an encrypted SSH connection between a Master Node (VM)\n
and the host machine through which API server port can be relayed.\n\n
Usage: $0 [ [--help | -h | help] | <Master Host IP> <Master IP> ]\n
\tMaster Host IP: \tprivate IP address of the host in the LAN\n
\tMaster IP: \tIP address of Master Node (VM)\n\n
Example: $0 192.168.0.10 192.168.84.10\n
will run:\n
\tssh -F $SSH_CONFIG $MasterUser@192.168.84.10 \
-N -f -L 192.168.0.10:$APIPort:192.168.84.10:$APIPort"

if [[ "$#" = "1" ]] &&
		[[ "$1" = "--help" || "$1" = "-h" || "$1" = "help" ]]; then
	echo -e $MSG; exit 0
fi

if [[ "$#" != "2" ]]; then
	echo -e $MSG; exit 1
fi

echo "ssh -F $SSH_CONFIG $MasterUser@$MasterIP -N -f -L \
	$MasterHostIP:$APIPort:$Master:$APIPort"

sshpass -p $MasterPassword ssh -F $SSH_CONFIG \
	$MasterUser@$MasterIP -N -f -L $MasterHostIP:$APIPort:$MasterIP:$APIPort

echo PID: `pgrep -n ssh`
