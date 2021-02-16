# ansible-demo
Create sales demos on k8s/OpenShift with Ansible

To use:

1. Base64 encode your kubeconfig (must have only one context -- this is an Ansible limitation) and your docker config.json with read access to gcr.io/rox-se.  (`base64 -w 0 kubeconfig`...)
2. Copy `docker-compose.yml` and `sample.env` from the repo.  Rename `sample.env` to `config.env` and put the proper values for each of the variables in there.  For example:

```
KUBECONFIG_BASE64=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gVml2YW11cyBmYWNpbGlzaXMgZWxlaWZlbmQgZWxlbWVudHVtLiBBbGlxdWFtIHVsbGFtY29ycGVyIHJpc3VzIGxvcmVtLCBuZWMgYXVjdG9yLgo=
DOCKERCONFIG_BASE64=V2l0aCBTdGFja1JveCwgUmVkIEhhdCBzdHJlbmd0aGVucyBjdXN0b21lcnPigJkgYWJpbGl0eSB0byBidWlsZCwgZGVwbG95IGFuZCBydW4gYXBwbGljYXRpb25zIG1vcmUgc2VjdXJlbHkgYWNyb3NzIHRoZSBvcGVuIGh5YnJpZCBjbG91ZAo=
CENTRAL_PORT=443
CENTRAL_ADDR=central-stackrox.apps.neil-demo.openshift.roxse.io
ADMIN_PASSWORD=ThisIsAnUnusuallyStrongPassphraseThatYou'llEndUpTypoing
ORCHESTRATOR=openshift
AUTH_CLIENT_ID=Ym9vLXlhaCBib3kgZGlkIHlvdSByZWFsbHkgZGVjb2RlIGFsbCB0aGVzZT8K
AUTH_DOMAIN=abc123.auth0.com
```

3. Invoke the `docker-compose.yml` with `docker-compose up ansible-demo-build`

A few notes:

* Auth0 integration is there but it's not going to work until we figure out the right approach for allowed callback URLs.
* The process baseline is now locked for deployments that have rogue processes runing in them.
* Not yet implemented:
  - Slack notification
  - There might be other things 
