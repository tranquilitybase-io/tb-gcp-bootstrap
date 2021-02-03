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

module "service-accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "3.0.1"

  project_id    = var.project_id
  names         = [local.sa_name]
  project_roles = local.project_roles

  depends_on = [module.project-services]
}

# due to the modules restrictions a for_each can't be used here
module "folder-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  version = "~> 6.4"

  folders = [var.folder_id]
  mode = "additive"

  bindings = {
    "roles/resourcemanager.folderAdmin" = [
      local.sa_email_role_format,
    ]
   "roles/resourcemanager.projectCreator" = [
      local.sa_email_role_format,
    ]
    "roles/resourcemanager.projectDeleter" = [
      local.sa_email_role_format,
    ]
    "roles/billing.projectManager" = [
      local.sa_email_role_format,
    ]
    "roles/compute.networkAdmin" = [
      local.sa_email_role_format,
    ]
    "roles/compute.xpnAdmin" = [
      local.sa_email_role_format,
    ]
    "roles/compute.networkUser" = [
      local.sa_email_role_format,
    ]
    "roles/cloudkms.admin" = [
      local.sa_email_role_format,
    ]
    "roles/logging.logWriter" = [
      local.sa_email_role_format,
    ]
    "roles/logging.configWriter" = [
      local.sa_email_role_format,
    ]
  }

  depends_on = [module.project-services, module.service-accounts]

}

#module "billing-account-iam" {
#  source = "terraform-google-modules/iam/google//modules/billing_accounts_iam"
#
#  mode = "additive"
#
#  billing_account_ids = [var.billing_id]
#  bindings = {
#    "roles/billing.admin" = [
#      "serviceAccount:${google_service_account.sa.email}"
#    ]
#  }
#}

module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id    = var.project_id
  activate_apis = var.project_apis
}

### need to fork and update to include audit on folder
### https://github.com/terraform-google-modules/terraform-google-iam/tree/1df0f6a6a385ba92e831937ee9772a2c5508e302/modules/audit_config
resource "google_folder_iam_audit_config" "audit_logging" {
  folder  = var.folder_id
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

#allow-iap
module "net-firewall" {
  source                  = "terraform-google-modules/network/google//modules/fabric-net-firewall"
  project_id              = var.project_id
  network                 = local.network_name
  custom_rules = {
    ingress-sample = {
      description          = "IAP"
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["35.235.240.0/20"]
      sources              = []
      targets              = ["iap"]
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = []
        }
      ]
      extra_attributes = {}
    }
  }

  depends_on = [module.project-services, module.vpc]
}

#sa for kubernetes cluster
module "service-account" {
  source = "terraform-google-modules/service-accounts/google"
  version = "3.0.1"

  project_id = var.project_id
  names = [local.sa_name]
  project_roles = []
}
