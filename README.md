# Using terraform to provision a [free-tier](https://cloud.google.com/free/docs/gcp-free-tier#always-free-usage-limits) google cloud compute engine which will only allow access via Identity-Aware Proxy (IAP) or wireguard VPN

Benefits/Uses of this approach:

* ~~No external-facing IP for a VM~~ cloud NAT isn't yet free tier
* Essentially https-based SSH access to a VM (via the gcloud-wrapped IAP session)
* Remote, secure 'home shell' (additional egress charges may apply)
* Secure https-based ssh proxy to access other remote ssh resources (additional egress charges may apply)
* pihole-processed DNS queries while connected via wireguard VPN

For example:

```shell
export GOOGLE_CLOUD_KEYFILE_JSON="<some google cloud account json file>"
terraform init
terraform apply

gcloud beta compute ssh \
  --account "<some GCP account address>" \\
  --project "<some GCP project name>" \\
  --zone "us-east1-b" \\
  --tunnel-through-iap "<some user>@cloud"
```

To complete wireguard VPN and pihole configuration, ssh to the VM and run `/wireguard-server.sh`

(requires terraform >= v0.12)

**TODO:** automate installation of pihle and wireguard so that a manual interaction is not necessary