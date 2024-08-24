module "rg" {
    source = "./module/resource_group"
    rg_name = "simulator-rg"
    rg_location = "South India"
    tags = {
      "Environment" = "Staging"
    }
}

module "vnet" {
    source = "./module/virtual_network"
    vnet_name = "simulator-vnet"
    vnet_location = module.rg.location
    rg_name = module.rg.rg_name
    vnet_address_space = ["10.0.0.0/16"]
    tags = {
      "Environment" = "Staging"
    }
}