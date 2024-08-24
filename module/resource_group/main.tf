resource "azurerm_resource_group" "resource_group" {
  name     = var.rg_name
  location = var.rg_location

  tags = merge(
    {
        Name = var.rg_name
        Provisioner = "Terraform"
    },
    var.tags
  )
}