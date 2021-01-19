output "vpc_id" {
  value = lookup(module.vpc.network, "id", "noid")
}

output "subnet_id" {
  value = lookup(element(values(module.subnets.subnets),0), "id", "noid" )
}
