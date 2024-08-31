resource "azurerm_route_table" "route_table" {
  name                = var.rt_name
  location            = var.rt_location
  resource_group_name = var.rg_name
  
  dynamic "route" {
    for_each = var.rt_route
    content {
      name = route.value.name
      address_prefix = route.value.address_prefix
      next_hop_type = route.value.next_hop_type
    }
  }

  tags = merge(
    {
      Name        = var.rt_name
      Provisioner = "Terraform"
    },
    var.tags
  )
}