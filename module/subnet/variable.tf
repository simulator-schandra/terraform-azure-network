variable "private_link_service_network_policies_enabled" {
  type = bool
  default = false
}

variable "private_endpoint_network_policies" {
  type = string
  default = "Disabled"
}

variable "default_outbound_access_enabled" {
  type = bool
  default = false
}

variable "subnet_name" {
  type = list(string)
}

variable "rg_name" {
  type = string
}

variable "vnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = list(list(string))
}
