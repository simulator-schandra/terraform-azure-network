module "network_skeleton" {
  source             = "../"
  rg_name            = "simulator-rg"
  rg_location        = "South India"
  vnet_name          = "simulator-vnet"
  vnet_address_space = ["10.0.0.0/20"]
  pub_subnet_name    = ["simulator-sub-pub-1", "simulator-sub-pub-2"]
  pub_subnet_cidr    = [["10.0.0.0/23"], ["10.0.2.0/23"]]
  pvt_subnet_name    = ["simulator-sub-pvt-1", "simulator-sub-pvt-2"]
  pvt_subnet_cidr    = [["10.0.4.0/23"], ["10.0.6.0/23"]]
  nat_name           = "simulator-nat"
  network_tags = {
    "Environment" = "Staging"
  }

}
