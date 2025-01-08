output "rg_id" {
  value = module.rg.rg_id
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "pub_subnet_ids" {
  value = module.public_subnet.subnet_ids
}

output "pvt_subnet_ids" {
  value = module.private_subnet.subnet_ids
}

output "nat_id" {
  value = module.nat.nat_id
}

output "nat_pip_id" {
  value = module.nat.nat_pip_id
}