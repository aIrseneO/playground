#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[Step 0] Node - Install sshpass to automate file transfert"
apt-get install -y sshpass  #> /dev/null 2>&1

echo -e "\n[Step 1] Extrating the joining command file from the master node"
sshpass -p "vagrant" scp -F /home/vagrant/.ssh/config \
	$MASTER:/home/vagrant/joincluster.sh joincluster.sh #2> /dev/null

echo -e "\n[Step 2] Node joining the k8s cluster"
bash joincluster.sh #> /dev/null 2>&1
