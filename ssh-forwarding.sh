#!/bin/bash
#
# Local:
#	ssh vagrant@master -N -f -L 8080:<cluster-service:port>
#
# Remote:
#	Relay server:
#		/etc/ssh/sshd_config
#			GatewayPorts yes
#
#	ssh <relay-server> -N -f -R <relay-server:port>:<local-server:port>
