variable "traffic_managers" {
  description = "Map of Traffic Manager configurations"
  type = map(object({
    name       = string
    rg_name    = string
    endpoints  = map(object({
      name     = string
      target   = string
      priority = number
    }))
  }))
}
