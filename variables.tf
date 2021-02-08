# Copyright 2021 The Tranquility Base Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

variable "billing_id" {
  type        = string
  description = "billing ID to attach project"
}

variable "region" {
  description = "default region"
  type        = string
  default     = "europe-west1"
}

variable "project_id" {
  type        = string
  description = "project id to deploy into"
}

variable "folder_id" {
  type        = string
  description = "folder id to deploy into"
}

variable "project_roles" {
  description = "roles to attach to project"
  type        = list(string)
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
  type        = list(string)
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
    "runtimeconfig.googleapis.com",
    "iap.googleapis.com"
  ]
}

variable "random_id" {
}

variable "secondary_ranges" {
  default = [
    {
      range_name    = "gke-pods-snet"
      ip_cidr_range = "10.1.0.0/17"
    },
    {
      range_name    = "gke-services-snet"
      ip_cidr_range = "10.1.128.0/20"
    },
  ]
}
