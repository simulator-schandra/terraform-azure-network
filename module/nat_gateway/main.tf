resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  count               = var.create_pip_prefix == true ? 1 : 0
  name                = "${var.nat_name}-pip-prefix"
  location            = var.nat_location
  resource_group_name = var.rg_name
  sku                 = var.sku_name
  ip_version          = var.ip_version
  prefix_length       = var.pip_prefix_length

  tags = merge(
    {
      Name        = "${var.nat_name}-pip-prefix"
      Provisioner = "Terraform"
    },
    var.tags
  )
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.nat_name}-pip"
  resource_group_name = var.rg_name
  location            = var.nat_location
  allocation_method   = var.allocation_method
  ip_version          = var.ip_version
  public_ip_prefix_id = var.create_pip_prefix == true ? azurerm_public_ip_prefix.public_ip_prefix[0].id : null
  sku                 = var.sku_name
  sku_tier            = var.sku_tier

  tags = merge(
    {
      Name        = "${var.nat_name}-pip"
      Provisioner = "Terraform"
    },
    var.tags
  )
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.nat_name
  location            = var.nat_location
  resource_group_name = var.rg_name
  sku_name            = var.sku_name

  tags = merge(
    {
      Name        = var.nat_name
      Provisioner = "Terraform"
    },
    var.tags
  )
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_public_ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_id = azurerm_public_ip.public_ip.id
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "nat_gateway_public_ip_prefix_association" {
  count               = var.create_pip_prefix == true ? 1 : 0
  nat_gateway_id      = azurerm_nat_gateway.nat_gateway.id
  public_ip_prefix_id = azurerm_public_ip_prefix.public_ip_prefix[0].id
}
