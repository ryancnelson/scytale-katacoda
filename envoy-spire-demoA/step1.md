
first, we'll set up your environment.

we're running these steps for you now:

install go in this training environment:
`curl -O https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz ; tar -C tar -C /usr/local -xzf go1.12.6.linux-amd64.tar.gz ; export PATH=$PATH:/usr/local/go/bin ;`

clone the github repo for this exercise:
`git clone https://github.com/spiffe/spire.git`

build the environment and containers:
`cd spire/examples/envoy ; ./build.sh`

start up the docker-compose setup:  
`docker-compose up -d ; sleep 3 ; ./1-start-services.sh ; sleep 2 ; ./2-start-spire-agents.sh ; sleep 2 ; ./3-create-registration-entries.sh`


look at what we've got:
https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/

diagram:  `curl http://algo.rit.hm/diag.txt`{{execute HOST1}}

