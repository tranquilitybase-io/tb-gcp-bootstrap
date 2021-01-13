variable "billing_id" {
}

variable "region" {
  default = "europe-west1"
}

variable "project_id" {
}

variable "folder_id" {
}

variable "project_roles" {
  type = list(string)
  default = [
    "roles/compute.instanceAdmin.v1",
    "roles/storage.admin",
    "roles/source.admin",
    "roles/logging.logWriter",
    "roles/logging.configWriter"
  ]
}

variable "project_apis" {
  default = [
    "cloudbilling.googleapis.com",
    "cloudkms.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "deploymentmanager.googleapis.com",
    "logging.googleapis.com",
    "serviceusage.googleapis.com",
    "sourcerepo.googleapis.com",
    "storage-api.googleapis.com",
    "runtimeconfig.googleapis.com"
  ]
}
