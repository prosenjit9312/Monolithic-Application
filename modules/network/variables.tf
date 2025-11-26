variable "vnets" {
   type = map(object({
     name = string
     location = string
     rg_name = string
     address_space = list(string)
    tags = map(string)
  private_endpoint_vnet_policies = optional(bool)
subnets = list(object({
      name           = string
      address_prefix = string
    }))

    
   }))
 }