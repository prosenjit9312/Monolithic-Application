variable "nsgs" {
  type = map(object({
    nsg_name       = string
    location       = string
    rg_name        = string
    tags           = map(string)
    ingress_rules  = list(object({
      name                       = string
      priority                   = number
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
    egress_rules  = list(object({
      name                       = string
      priority                   = number
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
  description = "Map of NSGs with their rules"
}
