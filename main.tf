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

locals {
  prefix                  = var.random_id
  root_folder_name        = format("%s-%s", "TranquilityBase", local.prefix)
  management_project_name = format("%s-%s", "management", local.prefix)
  network_name            = format("%s-%s", "vpc", local.prefix)
  router_name             = format("%s-%s", "router", local.prefix)
  project_roles           = [for role in var.project_roles : format("%s=>%s", var.project_id, role)]
  subnet_name             = "bootstrapsubnet"
  //sa_name                 = "bootstrapsa"
  sa_name                 = "kubernetes-ec"
  sa_email_role_format    = format("%s:%s@%s.%s", "serviceAccount", local.sa_name, var.project_id, "iam.gserviceaccount.com")
  secondary_ranges        = zipmap([local.subnet_name], [var.secondary_ranges])
}
