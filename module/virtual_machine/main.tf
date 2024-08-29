resource "azurerm_network_interface" "network_interface" {
  name                = "${var.vm_name}-nic"
  location            = var.vm_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "${var.vm_name}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = merge(
    {
      Name        = "${var.vm_name}-nic"
      Provisioner = "Terraform"
    },
    var.tags
  )
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  name                = var.vm_name
  resource_group_name = var.rg_name
  location            = var.vm_location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]
  priority = var.vm_priority

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("${var.admin_username_pub_key}")
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
    name                 = "${var.vm_name}-disk"
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  tags = merge(
    {
      Name        = var.vm_name
      Provisioner = "Terraform"
    },
    var.tags
  )
}
