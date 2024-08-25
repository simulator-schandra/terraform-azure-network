resource "azurerm_virtual_network" "virtual_network" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.rg_name
  address_space       = var.vnet_address_space
  # dns_servers         = var.vnet_dns_servers

  # dynamic "subnet" {
  #   for_each = var.vnet_subnet
  #   content {
  #     name                                          = subnet.value.name
  #     address_prefixes                              = subnet.value.address_prefixes
  #     security_group                                = subnet.value.security_group                  # If needed
  #     default_outbound_access_enabled               = subnet.value.default_outbound_access_enabled # If needed
  #     delegation                                    = subnet.value.delegation                      # If needed
  #     private_endpoint_network_policies             = subnet.value.private_endpoint_network_policies
  #     private_link_service_network_policies_enabled = subnet.value.private_link_service_network_policies_enabled
  #     route_table_id                                = subnet.value.route_table_id
  #     service_endpoints                             = subnet.value.service_endpoints
  #     service_endpoint_policy_ids                   = subnet.value.service_endpoint_policy_ids
  #   }
  # }

  tags = merge(
    {
      Name        = var.vnet_name
      Provisioner = "Terraform"
    },
    var.tags
  )
}
