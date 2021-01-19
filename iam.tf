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
  folders = [var.folder_id]

  mode = "additive"

  depends_on = [module.project-services, module.service-accounts]

  bindings = {
    "roles/resourcemanager.folderAdmin" = [
      local.sa_email,
    ]
   "roles/resourcemanager.projectCreator" = [
      local.sa_email,
    ]
    "roles/resourcemanager.projectDeleter" = [
      local.sa_email,
    ]
    "roles/billing.projectManager" = [
      local.sa_email,
    ]
    "roles/compute.networkAdmin" = [
      local.sa_email,
    ]
    "roles/compute.xpnAdmin" = [
      local.sa_email,
    ]
    "roles/compute.networkUser" = [
      local.sa_email,
    ]
    "roles/cloudkms.admin" = [
      local.sa_email,
    ]
    "roles/logging.logWriter" = [
      local.sa_email,
    ]
    "roles/logging.configWriter" = [
      local.sa_email,
    ]
  }
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

