

# variable "vnets" {
#   description = "vnets"
#   type = map(object({
#     name                        = string
#     rg_name                     = string
#     location                    = string
#     address_space               = list(string)
#     private_endpoint_vnet_policies = optional(bool)
#     subnets                     = list(object({
#       name           = string
#       address_prefix = string
#     }))
#   }))
# }

# variable "vms" {
#   description = "Virtual Machines"
#   type = map(object({
#     vm_name        = string
#     location       = string
#     rg_name        = string
#     subnet_id      = string
#     ssh_key        = string
#     size           = string
#     admin_username = string
#     os_disk_type   = string
#     tags           = map(string)
#     image          = object({
#       publisher = string
#       offer     = string
#       sku       = string
#       version   = string
#     })
#   }))
# }

# variable "databases" {
#   description = "Databases"
#   type = map(object({
#     db_type        = string
#     rg_name        = string
#     location       = string
#     server_name    = string
#     db_name        = string
#     admin_user     = string
#     admin_password = string
#     subnet_id      = string
#   }))
# }

# variable "appgateways" {
#   description = "Application Gateway configuration"
#   type = map(object({
#     name                        = string
#     rg_name                     = string
#     location                    = string
#     sku_name                    = string
#     capacity                    = number
#     frontend_port               = number
#     backend_port                = number
#     frontend_ip_config          = string
#     backend_pool_name           = string
#     http_setting_name           = string
#     listener_name               = string
#     request_routing_rule_name   = string
#     subnet_id                   = list(string)
#   }))
# }
