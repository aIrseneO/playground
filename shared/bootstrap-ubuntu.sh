#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo export c=apt >> /etc/profile.d/custom.sh
apt-get update -y
apt-get install -y man man-db git
