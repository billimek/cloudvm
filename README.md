# Using terraform to provision a [free-tier](https://cloud.google.com/free/docs/gcp-free-tier#always-free-usage-limits) google cloud compute engine which will only allow access via Identity-Aware Proxy (IAP)

Benefits/Uses of this approach:

* No external-facing IP for a VM
* Essentially https-based SSH access to a VM (via the gcloud-wrapped IAP session)
* Remote, secure 'home shell' (additional egress charges may apply)
* Secure https-based ssh proxy to access other remote ssh resources (additional egress charges may apply)

For example:

```shell
gcloud beta compute ssh \
  --account "<some GCP account address>" \\
  --project "<some GCP project name>" \\
  --zone "us-east1-b" \\
  --tunnel-through-iap "<some user>@cloud"
```
