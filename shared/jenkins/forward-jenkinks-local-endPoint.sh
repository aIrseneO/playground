#!/bin/bash

#TODO: update

REMOTE_USER=$1
REMOTE_SERVER=$2

ssh -N -f -R 8080:localhost:8080 $REMOTE_USER@$REMOTE_SERVER
