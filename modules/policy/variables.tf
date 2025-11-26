variable "policies" {
  description = "Map of Azure Policy definitions and assignments"
  type = map(object({
    name              = string
    display_name      = string
    category          = string
    policy_type       = string
    mode              = string
    scope             = string
    enforcement_mode  = string
    policy_rule       = any
  }))
}
