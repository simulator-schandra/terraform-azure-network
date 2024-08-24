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
  subscription_id = "d13e065d-de62-4283-8742-8aa75745e71d"
}