variable "monitors" {
  description = "Map of monitor configurations (Log Analytics, Diagnostics, Alerts)"
  type = map(object({
    rg_name             = string
    location            = string

    law_name            = string
    law_sku             = string
    retention_days      = number

    diag_name           = string
    target_resource_id  = string
    logs = list(object({
      category = string
      enabled  = bool
    }))
    metrics = list(object({
      category = string
      enabled  = bool
    }))

    alert_name          = string
    alert_description   = string
    alert_severity      = number
    metric_namespace    = string
    metric_name         = string
    alert_threshold     = number
    action_group_id     = string
  }))
}
