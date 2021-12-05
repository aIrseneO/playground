#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo export c=yum >> /etc/profile.d/custom.sh
yum update -y
yum install -y man man-pages man-db git bind-utils vim wget

