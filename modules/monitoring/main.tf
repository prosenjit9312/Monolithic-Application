# -----------------------------
# Azure Monitor (Generic)
# Includes Log Analytics Workspace, Diagnostic Settings, and Alerts
# -----------------------------

# Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "law" {
  for_each            = var.monitors
  name                = each.value.law_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  sku                 = each.value.law_sku
  retention_in_days   = each.value.reten
}