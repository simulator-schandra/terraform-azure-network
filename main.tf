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

module "nat" {
  source            = "./module/nat_gateway"
  nat_name          = "simulator-nat"
  rg_name           = "simulator-rg"
  nat_location      = "South India"
  create_pip_prefix = false
  tags = {
    "Environment" = "Staging"
  }
  depends_on = [module.vnet]
}

module "pvt_rt" {
  source      = "./module/route_table"
  rt_name     = "simulator-pvt-rt"
  rt_location = "South India"
  rg_name     = "simulator-rg"
  rt_route = [
    {
      name           = "route1"
      address_prefix = "10.0.0.0/20"
      next_hop_type  = "VnetLocal"
    },
    {
      name           = "route2"
      address_prefix = "10.0.0.0/20"
      next_hop_type  = "Internet"
    }
  ]
  tags = {
    "Environment" = "Staging"
  }
  depends_on = [ module.vnet ]
}

module "public_subnet" {
  source                          = "./module/subnet"
  subnet_name                     = ["simulator-sub-pub-1", "simulator-sub-pub-2"]
  rg_name                         = "simulator-rg"
  vnet_name                       = "simulator-vnet"
  subnet_cidr                     = [["10.0.0.0/23"], ["10.0.2.0/23"]]
  default_outbound_access_enabled = true
  depends_on                      = [module.nat]
}

module "private_subnet" {
  source      = "./module/subnet"
  subnet_name = ["simulator-sub-pvt-1", "simulator-sub-pvt-2"]
  rg_name     = "simulator-rg"
  vnet_name   = "simulator-vnet"
  subnet_cidr = [["10.0.4.0/23"], ["10.0.6.0/23"]]
  depends_on  = [module.nat]
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  count          = length([["10.0.4.0/23"], ["10.0.6.0/23"]])
  subnet_id      = module.private_subnet.subnet_ids[count.index]
  nat_gateway_id = module.nat.nat_id
  depends_on = [ module.private_subnet ]
}



# module "nsg" {
#   source = "./module/network_security_group"
#   nsg_name = "simulator-nsg"
#   nsg_location = "South India"
#   rg_name = "simulator-rg"
#   nsg_rule = [
#     {
#       name                       = "ssh_access_rule"
#       priority                   = 100
#       direction                  = "Inbound"
#       access                     = "Allow"
#       protocol                   = "Tcp"
#       source_port_range          = "22"
#       destination_port_range     = "22"
#       source_address_prefix      = "0.0.0.0/0"
#       destination_address_prefix = "*"
#     }
#   ]
#   tags = {
#     "Environment" = "Staging"
#   }

# }

# module "vm" {
#   source = "./module/virtual_machine"
#   vm_name = "simulator-vm"
#   vm_location = "South India"
#   rg_name = "simulator-rg"
#   subnet_id = "/subscriptions/d13e065d-de62-4283-8742-8aa75745e71d/resourceGroups/simulator-rg/providers/Microsoft.Network/virtualNetworks/simulator-vnet/subnets/simulator-sub-pub-1"
#   vm_size = "Standard_B1s" 
#   vm_priority = "Regular"
#   admin_username = "adminuser"
#   admin_username_pub_key = "~/.ssh/suyash.pub"
#   os_disk_caching = "ReadWrite"
#   os_disk_size_gb = "30"
#   os_disk_storage_account_type = "Standard_LRS"
#   source_image_offer = "0001-com-ubuntu-server-jammy"
#   source_image_publisher = "Canonical"
#   source_image_sku = "22_04-lts"
#   source_image_version = "latest"
#   tags = {
#     "Environment" = "Staging"
#   }
# }
