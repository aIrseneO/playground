#!/bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

MSG="Dowload file from GogleDrive using File ID\n\n
Usage: $0 FILE_ID OUTPUT_FILE"

[[ "$#" = 1 ]] && [[ "$1" = "--help"  || "$1" = "-h" ]] && \
	 echo -e $MSG && exit 0

if [ "$#" != 2 ]; then
	echo -e $MSG; exit 1
fi

set -e

function gdrive_download () {
	CONFIRM=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate "https://docs.google.com/uc?export=download&id=$1" -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
	wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$CONFIRM&id=$1" -O $2
	rm -rf /tmp/cookies.txt
}

gdrive_download $1 $2

# Credit
#https://gist.github.com/iamtekeste/3cdfd0366ebfd2c0d805
