#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

# curl -fsSL https://get.docker.com -o get-docker.sh
# sh ./get-docker.sh

VERSION="5:20.10.11~3-0~ubuntu-bionic"

echo -e "\n[Step 0] Uninstall old versions"
apt-get remove docker docker-engine docker.io containerd runc

echo -e "\n[Step 1] Set up Docker repository"
apt-get update
apt-get install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor \
	-o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo -e "\n[Step 2] Install Docker Engine"
apt-get update
apt-get install docker-ce=$VERSION docker-ce-cli=$VERSION containerd.io -y

#https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#https://docs.docker.com/compose/install/
