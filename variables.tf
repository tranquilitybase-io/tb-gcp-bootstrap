variable "billing_id" {
  type = string
  description = "billing ID to attach project"
}

variable "region" {
  description = "default region"
  type = string
  default = "europe-west1"
}

variable "project_id" {
  type = string
  description = "project id to deploy into"
}

variable "folder_id" {
  type = string
  description = "folder id to deploy into"
}

variable "project_roles" {
  description = "roles to attach to project"
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
  description = "project apis to enable"
  type = list(string)
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

variable "random_id" {
}
