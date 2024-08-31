variable "create_pip_prefix" {
  type = string
}

variable "nat_name" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "nat_location" {
  type = string
}

variable "sku_name" {
  type = string
  default = "Standard"
}

variable "ip_version" {
  type = string
  default = "IPv4"
}

variable "pip_prefix_length" {
  type = number
  default = 28
}

variable "tags" {
  type = map(string)
}

variable "allocation_method" {
  type = string
  default = "Static"
}

variable "sku_tier" {
  type = string
  default = "Regional"
}

