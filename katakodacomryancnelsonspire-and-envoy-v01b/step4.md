
use the spire-agent to fetch a proper client certificate, and write that to disk (for this demo):
`docker exec -it $webcontainer sh -c "/opt/spire/bin/spire-agent api fetch -write /tmp " `{{execute HOST1}}

----

*now that we have a client certificate*, we can curl from the mTLS envoy (8001): 
`docker exec -it $webcontainer sh -c "curl -vvv -k https://echo:8001/ --cacert /tmp/bundle.0.pem --key /tmp/svid.0.key --cert /tmp/svid.0.pem  | json" `{{execute HOST1}}

Note that we're not (yet) validating the certificate that envoy sends, because curl only validates the *hostname*.  So, we use '-k' to ignore that complaint.

----

look at the client-certificate we're using, note the short date TTL.
`docker exec -it $webcontainer sh -c "openssl x509 -in /tmp/svid.0.pem -text -noout -dates " `{{execute HOST1}}

----


Let's manually check that what's in the SAN field URI is the spiffe:// ID we're expecting, using the openssl command:

`docker exec -it $webcontainer sh -c "openssl s_client -connect echo:8001 -CAfile /tmp/bundle.0.pem" `{{execute HOST1}}` 

see the "Verification" line?  It's signed by Spire.

Now let's look inside the certificate, and see that it's got the spiffe:// ID we expect:

`docker exec -it $webcontainer sh -c "openssl s_client -connect echo:8001 -CAfile /tmp/bundle.0.pem 2>&1  | openssl x509 -text | egrep 'Subject Alternative|URI' " `{{execute HOST1}}


<img src="https://cdn-images-1.medium.com/max/800/0*QWV06vCtJu0KuuOA">




