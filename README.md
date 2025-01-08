Azure Network Terraform module
=====================================

This module is used to deploy a Network on Azure cloud using Terraform.

Prerequisites
--------------
- [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

Requirements
------------

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0.1 |


Usage
------

```hcl
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.0.1"
    }
  }
}

provider "azurerm" {
  features {}
}

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

```

Inputs
------

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| **rg_name** | Resource group name | `string` | `NA` | yes |
| **rg_location** | Resource group location | `string` | `NA` | yes |
| **vnet_name** | Virtual network name | `string` | `NA` | yes |
| **vnet_address_space** | Virtual network name | `list(string)` | `NA` | yes |
| **pub_subnet_name** | Public subnet names | `list(list(string))` | `NA` | yes |
| **pub_subnet_cidr** | Public subnet cidr's | `list(list(string))` | `NA` | yes |
| **pvt_subnet_name** | Private subnet names | `list(list(string))` | `NA` | yes |
| **pvt_subnet_cidr** | Private subnet cidr's | `list(list(string))` | `NA` | yes |
| **nat_name** | NAT name | `string` | `NA` | yes |
| **network_tags** | Network tags to be associated with every resource (Name tag will be applied by default) | `map(string)` | `NA` | yes |

Outputs
--------

| Name | Description |
|------|-------------|
| **Network_ids** | Network id's |

Revision History 
----------------

### Contributors

- Created by [Suyash Chandra](https://github.com/suyash1610)