variable "key_vaults" {
  description = "Map of Key Vaults to create"
  type = map(object({
    name                       = string
    location                   = string
    rg_name                    = string
    sku_name                   = string
    soft_delete_retention_days = optional(number)
    key_permissions            = optional(list(string))
    secret_permissions         = optional(list(string))
    tags                       = optional(map(string))
  }))
}

variable "key_vault_secrets" {
  description = "Map of secrets to store in Key Vaults"
  type = map(object({
    name       = string
    value      = string
    vault_key  = string # reference to key_vaults map key
  }))
}
