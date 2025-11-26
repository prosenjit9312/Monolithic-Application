variable "stgs" {
  type = map(object({
    name = string
    location = string
    rg_name = string
    account_replication_type = string
    account_tier = string
    public_network_access_enabled = bool
     
     tags = optional(object({
      environment = optional(string)
    }))
  }))
}