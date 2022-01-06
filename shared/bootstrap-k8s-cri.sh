#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo -e "\n[-- CRI --] Container runtime: Docker"

mkdir /etc/docker > /dev/null #2>&1
cat <<EOF > /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

systemctl enable docker > /dev/null #2>&1
systemctl daemon-reload > /dev/null #2>&1
systemctl restart docker > /dev/null #2>&1

# References
#	https://kubernetes.io/docs/setup/production-environment/container-runtimes/#docker
