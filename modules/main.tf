resource "random_id" "prefix" {
  byte_length = 8
}

locals {
  prefix                  = random_id.prefix.dec
  root_folder_name        = format("%s-%s", "TranquilityBase", local.prefix)
  management_project_name = format("%s-%s", "management", local.prefix)
  network_name            = format("%s-%s", "vpc", local.prefix)
  router_name             = format("%s-%s", "router", local.prefix)
  project_roles           = [for role in var.project_roles : format("%s=>%s", var.project_id, role)]
  subnet_name             = "bootstrapsubnet"
  sa_name                 = "bootstrapsa"
}
