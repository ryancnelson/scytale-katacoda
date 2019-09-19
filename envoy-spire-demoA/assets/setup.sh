#!/bin/sh -x
echo "running $0"
echo "running version aaab"
while [ \! -f /root/setup_environment.sh ] ; do echo "waiting for setup..." ; sleep 2 ; done

sh /root/setup_environment.sh

