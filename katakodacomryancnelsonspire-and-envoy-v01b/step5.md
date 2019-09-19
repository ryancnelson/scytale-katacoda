
exec into the spire-container and look at the server entries we have set up:

`docker exec -it $spirecontainer sh -c "/opt/spire/bin/spire-server entry show" `{{execute HOST1}}

----

this means that if we jump into a node that's got the webserver x509pop (proof-of-possession) node-attestor set up,
then we get an SVID for "spiffe://domain.test/web-server"

`docker exec -it $webcontainer sh -c "/opt/spire/bin/spire-agent api fetch"`{{execute HOST1}}

... and likewise, if we do the same operation, except on a node that's recognized as an "echo" x509pop node:

`docker exec -it $echocontainer sh -c "/opt/spire/bin/spire-agent api fetch"`{{execute HOST1}}

... we get an SVID for "spiffe://domain.test/echo-server"


-----

Now, let's break the demo: (on purpose)

exec down into the spire-server container and look at the server entries:

`docker exec -it $spirecontainer sh`

`spirecontainer-shell # /opt/spire/bin/spire-server entry show`


*now remove the entry that attests the webserver*
`spirecontainer-shell # /opt/spire/bin/spire-server entry delete -entryID XXXXXX`

`exit`


-----

now let's see if the webserver can still fetch an SVID like it used to:
`docker exec -it $webcontainer sh -c "/opt/spire/bin/spire-agent api fetch"`{{execute HOST1}}

...nope!

the echo server is still fine, though.

----

See how the web interface is doing:

----

re-create that entry:

`docker exec -it $spirecontainer sh`

`/opt/spire/bin/spire-server entry create --parentID spiffe://domain.test/spire/agent/x509pop/2963802ba4938e8a10180b7782d29c58e7282423 --spiffeID spiffe://domain.test/web-server --selector unix:user:root -ttl 60`







