module "rg" {
  source      = "./module/resource_group"
  rg_name     = "simulator-rg"
  rg_location = "South India"
  tags = {
    "Environment" = "Staging"
  }
}

module "vnet" {
  source             = "./module/virtual_network"
  vnet_name          = "simulator-vnet"
  vnet_location      = "South India"
  rg_name            = "simulator-rg"
  vnet_address_space = ["10.0.0.0/20"]
  tags = {
    "Environment" = "Staging"
  }
  depends_on = [module.rg]

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

module "nsg" {
  source = "./module/network_security_group"
  nsg_name = "simulator-nsg"
  nsg_location = "South India"
  rg_name = "simulator-rg"
  nsg_rule = [
    {
      name                       = "ssh_access_rule"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "22"
      destination_port_range     = "22"
      source_address_prefix      = "0.0.0.0/0"
      destination_address_prefix = "*"
    }
  ]
  tags = {
    "Environment" = "Staging"
  }
  
}

module "vm" {
  source = "./module/virtual_machine"
  vm_name = "simulator-vm"
  vm_location = "South India"
  rg_name = "simulator-rg"
  subnet_id = "/subscriptions/d13e065d-de62-4283-8742-8aa75745e71d/resourceGroups/simulator-rg/providers/Microsoft.Network/virtualNetworks/simulator-vnet/subnets/simulator-sub-pub-1"
  vm_availability_zone = ""
  vm_size = "Standard_F2"
  vm_priority = "Regular"
  admin_username = "adminuser"
  admin_username_pub_key = "~/.ssh/id_rsa.pub"
  os_disk_caching = "ReadWrite"
  os_disk_size_gb = "10"
  os_disk_storage_account_type = "Standard_LRS"
  source_image_offer = "0001-com-ubuntu-server-jammy"
  source_image_publisher = "Canonical"
  source_image_sku = "22_04-lts"
  source_image_version = "latest"
  tags = {
    "Environment" = "Staging"
  }
}
