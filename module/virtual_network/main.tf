resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space

  tags = merge(
    {
        Name = var.rg_name
    },
    var.tags
  )
}