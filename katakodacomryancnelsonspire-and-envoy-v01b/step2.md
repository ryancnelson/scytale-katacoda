inventory our docker containers:

`webcontainer=$( docker ps | grep envoy_web | awk '{print $1}') ; \
echocontainer=$( docker ps | grep envoy_echo | awk '{print $1}') ; \
spirecontainer=$(docker ps | grep envoy_spire-server | awk '{print $1}') `{{execute HOST1}}


augment our web container with some tools:
`docker exec -it $webcontainer sh -c "apk add curl ; apk add openssl; apk add bash ; apk add vim ; apk add tcpdump ; apk add npm ; npm install -g json"  `{{execute HOST1}}


diagram:  `curl http://algo.rit.hm/diag.txt`{{execute HOST1}}


