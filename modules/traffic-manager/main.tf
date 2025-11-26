# Traffic Manager
resource "azurerm_traffic_manager_profile" "tm" {
  for_each                = var.traffic_managers
  name                    = each.value.name
  resource_group_name     = each.value.rg_name
  profile_status          = "Enabled"
  traffic_routing_method  = "Priority"

  dns_config {
    relative_name = each.value.name
    ttl           = 30
  }

  monitor_config {
    protocol = "Http"
    port     = 80
    path     = "/"
  }
}

# Flatten endpoint map for dynamic for_each
locals {
  tm_endpoints_flat = merge([
    for tm_key, tm_value in var.traffic_managers : {
      for ep_key, ep_value in tm_value.endpoints :
      "${tm_key}-${ep_key}" => merge(ep_value, {
        tm_key = tm_key
      })
    }
  ]...)
}

resource "azurerm_traffic_manager_endpoint" "tm_endpoints" {
  for_each = local.tm_endpoints_flat

  name                = each.value.name
  resource_group_name = var.traffic_managers[each.value.tm_key].rg_name
  profile_name        = azurerm_traffic_manager_profile.tm[each.value.tm_key].name
  type                = "externalEndpoints"
  target              = each.value.target
  priority            = each.value.priority
}
