resource "azurerm_subnet" "subnet" {
  count = length(var.subnet_list)
  name                                          = var.subnet_list[count.index]
  resource_group_name                           = var.rg_name
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = var.address_prefixes[count.index]
  default_outbound_access_enabled               = var.default_outbound_access_enabled
  private_endpoint_network_policies             = var.private_endpoint_network_policies
  private_link_service_network_policies_enabled = var.private_link_service_network_policies_enabled
}
