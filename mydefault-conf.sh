#! /bin/bash

################################################################################
#     Copyright (c) 2021 Arsene Temfack                                        #
#                                                                              #
#     SPDX-License-Identifier: MIT                                             #
################################################################################

MSG="Update Vim and Bash configuration files:\n
- .vimrc\n
- .bashrc; .bash_fancy; .bash_aliases\n\n
Usage: $0 USERS..."

[[ "$#" = "0" || "$1" = "--help"  || "$1" = "-h" ]] && \
	 echo -e $MSG && exit 0

git clone https://github.com/airseneo/linux.git /_linux

for USER in $@; do
	cd /_linux/setup && bash vim.sh > /dev/null
	cd /_linux/setup && sudo -H -u $USER bash -c "bash vim.sh" > /dev/null
	cd /_linux/setup && bash bash.sh > /dev/null
	cd /_linux/setup && sudo -H -u $USER bash -c "bash bash.sh" > /dev/null
done

rm -rf /_linux

echo "Done!"
