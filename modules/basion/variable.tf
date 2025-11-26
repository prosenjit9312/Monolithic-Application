variable "bastions" {
  type = map(object({
    location              = string
    resource_group_name   = string
    vnet_name             = string
    bastion_subnet_prefix = string
  }))
}
