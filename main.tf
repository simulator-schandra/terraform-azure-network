module "rg" {
  source      = "simulator-schandra/rg/azure"
  version     = "0.0.2"
  rg_name     = var.rg_name
  rg_location = var.rg_location
  tags        = var.network_tags
}

module "vnet" {
  source             = "simulator-schandra/vnet/azure"
  version            = "0.0.2"
  vnet_name          = var.vnet_name
  vnet_location      = var.rg_location
  rg_name            = var.rg_name
  vnet_address_space = var.vnet_address_space
  tags               = var.network_tags
  depends_on         = [module.rg]
}

module "public_subnet" {
  source                          = "simulator-schandra/subnet/azure"
  version                         = "0.0.2"
  subnet_name                     = var.pub_subnet_name
  rg_name                         = var.rg_name
  vnet_name                       = var.vnet_name
  subnet_cidr                     = var.pub_subnet_cidr
  default_outbound_access_enabled = true
  depends_on                      = [module.vnet]
}

module "private_subnet" {
  source      = "simulator-schandra/subnet/azure"
  version     = "0.0.2"
  subnet_name = var.pvt_subnet_name
  rg_name     = var.rg_name
  vnet_name   = var.vnet_name
  subnet_cidr = var.pvt_subnet_cidr
  depends_on  = [module.vnet]
}

module "nat" {
  source            = "simulator-schandra/nat/azure"
  version           = "0.0.2"
  nat_name          = var.nat_name
  rg_name           = var.rg_name
  nat_location      = var.rg_location
  create_pip_prefix = false
  tags              = var.network_tags
  depends_on        = [module.private_subnet]
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  count          = length(var.pvt_subnet_cidr)
  subnet_id      = module.private_subnet.subnet_ids[count.index]
  nat_gateway_id = module.nat.nat_id
  depends_on     = [module.nat]
}
