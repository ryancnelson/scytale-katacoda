
try some debug commands:

----

connect directly from the web-container to the echo service, with "curl"
`docker exec -it $webcontainer sh -c "curl -s http://echo:8081/ | json "  `{{execute HOST1}}

Talking directly to the echo service works fine.

----

connect from web to envoy+mTLS (8001) on the echo server, and see that it's demanding a client certificate  :
`docker exec -it $webcontainer sh -c "openssl s_client -connect echo:8001 < /dev/null 2>&1" `{{execute HOST1}}

(grep for the interesting bits:)
`docker exec -it $webcontainer sh -c "openssl s_client -connect echo:8001 < /dev/null 2>&1 | grep -A2 'Acceptable'   "`{{execute HOST1}}

----

try to use curl to that envoy.  *This will fail*, because we're not sending an acceptable client-certificate to satisfy mTLS: 
`docker exec -it $webcontainer sh -c "curl -vvv -k https://echo:8001/  | json" `{{execute HOST1}}


----

note that we *can* use curl to talk to envoy on it's regular TLS port, 8002 (not mTLS, which demands a client cert as well):
`docker exec -it $webcontainer sh -c "curl -vvv -k https://echo:8002/  | json" `{{execute HOST1}}


----

