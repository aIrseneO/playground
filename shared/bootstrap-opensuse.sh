#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

echo export c=zypper >> /etc/profile.d/custom.sh
zypper update -y
zypper install -y man man-pages vim git
