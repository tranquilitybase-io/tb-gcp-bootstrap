output "vpc_id" {
  value = module.vpc.network
}

output "subnet-lookup-element-values" {
  value = lookup(element(values(module.subnets.subnets),0), "id", "noid" )
}
