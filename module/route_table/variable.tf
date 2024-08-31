variable "rt_name" {
  type = string
}

variable "rt_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "rt_route" {
  type = list(map(string))
  default = [ {
    name = "value"
    address_prefix = ""
    next_hop_type = "VirtualNetworkGateway"
  } ]
}
