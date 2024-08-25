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

variable "vnet_dns_servers" {
  type = list(string)
  default = []
}

variable "vnet_subnet" {
  type = list(object({
    name                                          = string
    address_prefixes                              = list(string)
    security_group                                = string   # Optional: Referencing a security group
    default_outbound_access_enabled               = bool     # Optional: Setting outbound access
    delegation                                    = list(object({
      name = string
      service_delegation = list(object({
        actions = list(string)
        name    = string
      }))
    }))
    private_endpoint_network_policies             = bool
    private_link_service_network_policies_enabled = bool
    route_table_id                                = string
    service_endpoints                             = list(string)
    service_endpoint_policy_ids                   = list(string)
  }))
  default = []
}
