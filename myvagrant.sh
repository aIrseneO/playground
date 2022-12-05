# !/bin/bash

set -e

VAGRANT=/usr/bin/vagrant
TR=/usr/bin/tr
SED=/usr/bin/sed
AWK=/usr/bin/awk

function parse_yaml {
   local prefix=$2
   local s='[[:space:]]*' w='[a-zA-Z0-9_]*' fs=$(echo @|$TR @ '\034')
   $SED -ne "s|^\($s\):|\1|" \
        -e "s|^\($s\)\($w\)$s:$s[\"']\(.*\)[\"']$s\$|\1$fs\2$fs\3|p" \
        -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
   $AWK -F$fs '{
      indent = length($1)/2;
      vname[indent] = $2;
      for (i in vname) {if (i > indent) {delete vname[i]}}
      if (length($3) > 0) {
        vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])("_")}
        printf("%s%s%s=\"%s\"\n", "'$prefix'",vn, $2, $3);
      }
   }'
}
eval $(parse_yaml $1)

NAME=$NAME \
IMAGE=$IMAGE \
TAG=$TAG \
NETWORK=$NETWORK \
IP=$IP \
HOSTNAME=$HOSTNAME \
PROVIDER=$PROVIDER \
CPU=$CPU \
MEMORY=$MEMORY \
PLAYBOOK=$PLAYBOOK \
$VAGRANT ${@:2}