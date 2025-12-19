variable "frontdoors" {
  type = map(object({
    name         = string
    rg_name      = string
    location     = string
    backend_host = string
    tags         = optional(map(string))
  }))
}
