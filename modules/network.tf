module "vpc" {
  source                  = "terraform-google-modules/network/google//modules/vpc"
  version                 = "~> 3.0.0"
  project_id              = var.project_id
  network_name            = local.network_name
  auto_create_subnetworks = false
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
}
