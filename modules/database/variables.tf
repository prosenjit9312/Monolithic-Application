variable "databases" {
  type = map(object({
    db_type        = string
    server_name    = string
    db_name        = string
    rg_name        = string
    location       = string
    admin_user     = string
    admin_password = string
    sku_name       = optional(string)
    version        = optional(string)
    max_size_gb    = optional(number)
    backup_retention_days = optional(number)
    storage_mb     = optional(number)
    subnet_id      = string
    tags           = map(string)
  }))
}

