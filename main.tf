module "vnet" {
  source             = "./module/virtual_network"
  vnet_name          = "simulator-vnet"
  vnet_location      = "South India"
  rg_name            = "simulator-rg"
  vnet_address_space = ["10.0.0.0/20"]
  tags = {
    "Environment" = "Staging"
  }
}

module "public_subnet" {
  source                          = "./module/subnet"
  subnet_name                     = ["simulator-sub-pub-1", "simulator-sub-pub-2"]
  rg_name                         = "simulator-rg"
  vnet_name                       = "simulator-vnet"
  subnet_cidr                     = [["10.0.0.0/23"], ["10.0.2.0/23"]]
  default_outbound_access_enabled = true
  depends_on                      = [module.vnet]
}

module "private_subnet" {
  source      = "./module/subnet"
  subnet_name = ["simulator-sub-pvt-1", "simulator-sub-pvt-2"]
  rg_name     = "simulator-rg"
  vnet_name   = "simulator-vnet"
  subnet_cidr = [["10.0.4.0/23"], ["10.0.6.0/23"]]
  depends_on  = [module.vnet]
}

module "nat" {
  source            = "./module/nat_gateway"
  nat_name          = "simulator-nat"
  rg_name           = "simulator-rg"
  nat_location      = "South India"
  create_pip_prefix = false
  tags = {
    "Environment" = "Staging"
  }
  depends_on = [module.private_subnet]
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  count          = length([["10.0.4.0/23"], ["10.0.6.0/23"]])
  subnet_id      = module.private_subnet.subnet_ids[count.index]
  nat_gateway_id = module.nat.nat_id
  depends_on     = [module.nat]
}