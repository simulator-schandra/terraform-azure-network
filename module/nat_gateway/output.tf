output "nat_id" {
  value = azurerm_nat_gateway.nat_gateway.id
}

output "nat_pip_id" {
  value = azurerm_public_ip.public_ip.id
}

output "nat_pip_prefix_id" {
  value = azurerm_public_ip_prefix.public_ip_prefix.*.id
}