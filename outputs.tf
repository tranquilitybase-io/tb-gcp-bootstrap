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

output "network_name" {
  value = lookup(module.vpc.network, "name", "noname")
}

output "network_id" {
  value = lookup(module.vpc.network, "vpc_id", "noid")
}

output "network_self_link" {
  value = lookup(module.vpc.network, "self_link", "no_self_link")
}

output "network_all" {
  value = module.vpc.network
}

output "subnet_name" {
  value = lookup(element(values(module.subnets.subnets), 0), "name", "noname")
}

output "subnet_self_link" {
  value = lookup(element(values(module.subnets.subnets), 0), "self_link", "no_self_link")
}

output "subnet_all" {
  value = module.subnets.subnets
}

output "service_account_name" {
  value = module.service-accounts
}
