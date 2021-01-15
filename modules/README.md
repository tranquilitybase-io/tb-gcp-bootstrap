## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_id | billing ID to attach project | `string` | n/a | yes |
| folder\_id | folder id to deploy into | `string` | n/a | yes |
| project\_apis | project apis to enable | `list(string)` | <pre>[<br>  "cloudbilling.googleapis.com",<br>  "cloudkms.googleapis.com",<br>  "cloudresourcemanager.googleapis.com",<br>  "compute.googleapis.com",<br>  "container.googleapis.com",<br>  "containerregistry.googleapis.com",<br>  "deploymentmanager.googleapis.com",<br>  "logging.googleapis.com",<br>  "serviceusage.googleapis.com",<br>  "sourcerepo.googleapis.com",<br>  "storage-api.googleapis.com",<br>  "runtimeconfig.googleapis.com"<br>]</pre> | no |
| project\_id | project id to deploy into | `string` | n/a | yes |
| project\_roles | roles to attach to project | `list(string)` | <pre>[<br>  "roles/compute.instanceAdmin.v1",<br>  "roles/storage.admin",<br>  "roles/source.admin",<br>  "roles/logging.logWriter",<br>  "roles/logging.configWriter"<br>]</pre> | no |
| region | default region | `string` | `"europe-west1"` | no |

## Outputs

No output.
