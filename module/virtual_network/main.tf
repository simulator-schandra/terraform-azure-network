resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
  dns_servers = var.vnet_dns_servers

  tags = merge(
    {
        Name = var.vnet_name
        Provisioner = "Terraform"
    },
    var.tags
  )
}