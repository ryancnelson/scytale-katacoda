#!/bin/sh -x

while [ \! -f /root/setup_environment.sh ] ; do echo "waiting for setup..." ; sleep 2 ; done

sh /root/setup_environment.sh

