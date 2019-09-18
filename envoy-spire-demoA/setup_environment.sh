#!/bin/sh -x

echo "pull the github repo for this exercise:"
curl -O https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz 
tar -C tar -C /usr/local -xzf go1.12.6.linux-amd64.tar.gz 
export PATH=$PATH:/usr/local/go/bin 
##git clone https://github.com/spiffe/spire.git
git clone https://github.com/ryancnelson/spire.git

echo "build the environment and containers:"
cd spire/examples/envoy ; ./build.sh
echo "start up the docker-compose setup:  "
docker-compose up -d ;sleep 3;  ./1-start-services.sh ;sleep 2 ; ./2-start-spire-agents.sh ; sleep 2 ; ./3-create-registration-entries.sh && echo "env set up."
echo "All set!"

