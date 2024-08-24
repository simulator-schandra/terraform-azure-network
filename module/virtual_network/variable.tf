variable "vnet_name" {
  type = string
}

variable "vnet_address_space" {
  type = list(string)
}

variable "rg_name" {
  type = string
}

variable "vnet_location" {
  type = string
}

variable "tags" {
  type = map(string)
}
