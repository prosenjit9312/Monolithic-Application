variable "loadbalancers" {
  description = "Map of Load Balancer configurations"
  type = map(object({
    name     = string
    location = string
    rg_name  = string
  }))
}
