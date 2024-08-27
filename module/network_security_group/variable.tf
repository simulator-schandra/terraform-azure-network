variable "nsg_name" {
  type = string
}

variable "nsg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "nsg_rule" {
  type = list(map(string))
}

variable "tags" {
  type = map(string)
}

