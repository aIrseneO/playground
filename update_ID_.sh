#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

MSG="Reset/Update the variable \`__ID__\` in Vagrantfile.\n\n
Usage: $0 [ reset | ID | --help | -h | help ]"

if [[ "$#" == "1" ]]; then 
	if [[ "$1" == "reset" ]]; then
		sed -i "s:ID = .*:ID = \"__ID__\":g" Vagrantfile
		echo "__ID__ has been reset"; exit $?
	elif [[ "$1" == "--help" || "$1" = "-h" || "$1" = "help" ]]; then
		echo -e $MSG ; exit $?
	fi
	sed -i "s:ID = .*:ID = \"$1\":g" Vagrantfile
	echo "__ID__ has been updated to: $1"; exit $?
fi
echo -e $MSG; exit 1;
