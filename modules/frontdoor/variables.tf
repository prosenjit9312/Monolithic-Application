variable "frontdoors" {
  description = "Map of Azure Front Door Standard/Premium configurations"
  type = map(object({
    name         = string        # Front Door profile name
    rg_name      = string        # Resource group name
    location     = string        # Azure region, e.g., 'Central India'
    backend_host = string        # App backend hostname (FQDN)
    tags         = optional(map(string), {})  # Optional tags
  }))
}
