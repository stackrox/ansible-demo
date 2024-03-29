# ansible-demo

Deploy StackRox and create sales demos on k8s/OpenShift with Ansible

To use:

1. Base64 encode your kubeconfig (must have only one context -- this is an Ansible limitation) and your docker config.json with read access to gcr.io/rox-se.  (`base64 -w 0 kubeconfig`...)
2. Copy `docker-compose.yml` and `sample.env` from the repo.  Rename `sample.env` to `config.env` and put the proper values for each of the variables in there.  For example:

```
KUBECONFIG_BASE64=TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4gVml2YW11cyBmYWNpbGlzaXMgZWxlaWZlbmQgZWxlbWVudHVtLiBBbGlxdWFtIHVsbGFtY29ycGVyIHJpc3VzIGxvcmVtLCBuZWMgYXVjdG9yLgo=
DOCKERCONFIG_BASE64=V2l0aCBTdGFja1JveCwgUmVkIEhhdCBzdHJlbmd0aGVucyBjdXN0b21lcnPigJkgYWJpbGl0eSB0byBidWlsZCwgZGVwbG95IGFuZCBydW4gYXBwbGljYXRpb25zIG1vcmUgc2VjdXJlbHkgYWNyb3NzIHRoZSBvcGVuIGh5YnJpZCBjbG91ZAo=
CENTRAL_PORT=443
ADMIN_PASSWORD=ThisIsAnUnusuallyStrongPassphraseThatYou'llEndUpTypoing
ORCHESTRATOR=openshift
IMAGE_PULL_USER=<quay.io username>
IMAGE_PULL_PASSWORD=<password for image pull account>
```

(optional:  If supplied, Auth0 will be configured

```
AUTH_CLIENT_ID=Ym9vLXlhaCBib3kgZGlkIHlvdSByZWFsbHkgZGVjb2RlIGFsbCB0aGVzZT8K
AUTH_DOMAIN=abc123.auth0.com
```

Add the appropriate values to `config.env`.)


(optional:  If `CENTRAL_ADDR` is supplied, the playbook will skip installing Central and the cluster bundle.)
(optional:  If you want to pull images from `stackrox.io` directly, omit IMAGE_REGISTRY and provide credentials for `stackrox.io`.)

3. Invoke the `docker-compose.yml` with `docker-compose run ansible-demo-build`

A few notes:

* Auth0 integration is there but it's not going to work until we figure out the right approach for allowed callback URLs.
* The process baseline is now locked for deployments that have rogue processes runing in them.
* Not yet implemented:
  - Slack notification
  - There might be other things
