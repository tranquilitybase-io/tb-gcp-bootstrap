module "service-accounts" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "3.0.1"

  project_id    = var.project_id
  names         = [local.sa_name]
  project_roles = local.project_roles
}

module "folder-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  folders = [var.folder_name]

  mode = "additive"

  bindings = {
    "roles/${local.folder_roles}" = [
      "serviceAccount:${module.service-accounts.email}"
    ]
  }
}

/*
module "folder-iam" {
  source  = "terraform-google-modules/iam/google//modules/folders_iam"
  folders = [var.folder_name]

  mode = "additive"

  for_each = toset(var.folder_roles)
  bindings = {
    "roles/${each.value}" = [
      "serviceAccount:${module.service-accounts.email}"
    ]
  }
}
/*
module "billing-account-iam" {
  source = "terraform-google-modules/iam/google//modules/billing_accounts_iam"

  mode = "additive"

  billing_account_ids = [var.billing_id]
  bindings = {
    "roles/billing.admin" = [
      "serviceAccount:${module.service-accounts.email}"
    ]
  }
}
*/
module "project-services" {
  source  = "terraform-google-modules/project-factory/google//modules/project_services"
  version = "4.0.0"

  project_id    = var.project_id
  activate_apis = var.project_apis
}

### need to fork and update to include audit on folder
### https://github.com/terraform-google-modules/terraform-google-iam/tree/1df0f6a6a385ba92e831937ee9772a2c5508e302/modules/audit_config
resource "google_folder_iam_audit_config" "audit_logging" {
  folder  = var.folder_name
  service = "allServices"
  audit_log_config {
    log_type = "ADMIN_READ"
  }
}

