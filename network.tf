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

module "vpc" {
  source                  = "terraform-google-modules/network/google//modules/vpc"
  version                 = "~> 3.0.0"
  project_id              = var.project_id
  network_name            = local.network_name
  auto_create_subnetworks = false

  depends_on = [module.project-services]
}

module "subnets" {
  source       = "terraform-google-modules/network/google//modules/subnets"
  version      = "~> 3.0.0"
  project_id   = var.project_id
  network_name = module.vpc.network_name

  subnets = [
    {
      subnet_name           = local.subnet_name
      subnet_ip             = "192.168.0.0/28"
      subnet_region         = var.region
      subnet_private_access = true
    }
  ]

  secondary_ranges = local.secondary_ranges
}

module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 0.4"

  name    = local.router_name
  project = var.project_id
  region  = var.region
  network = module.vpc.network_self_link
}

module "cloud-nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "~> 1.2"

  project_id = var.project_id
  region     = var.region
  router     = local.router_name

  depends_on = [module.cloud_router]
}
