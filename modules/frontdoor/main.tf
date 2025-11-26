# -----------------------------
# Azure Front Door Standard
# -----------------------------
resource "azurerm_frontdoor_standard_profile" "fd_profile" {
  for_each            = var.frontdoors
  name                = each.value.name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  sku_name            = "Standard_AzureFrontDoor"
  tags                = lookup(each.value, "tags", {})
}

resource "azurerm_frontdoor_standard_endpoint" "fd_endpoint" {
  for_each      = var.frontdoors
  name          = "${each.value.name}-endpoint"
  front_door_id = azurerm_frontdoor_standard_profile.fd_profile[each.key].id
}

resource "azurerm_frontdoor_standard_origin_group" "fd_origin_group" {
  for_each                  = var.frontdoors
  name                      = "${each.value.name}-og"
  front_door_id             = azurerm_frontdoor_standard_profile.fd_profile[each.key].id
  session_affinity_enabled  = false
  restore_traffic_time_to_heal = 60

  health_probe {
    interval_in_seconds = 30
    path                = "/"
    protocol            = "Http"
    request_type        = "GET"
  }

  load_balancing {
    sample_size                     = 4
    successful_samples_required     = 2
    additional_latency_milliseconds = 0
  }
}

resource "azurerm_frontdoor_standard_origin" "fd_origin" {
  for_each                   = var.frontdoors
  name                       = "${each.value.name}-origin"
  front_door_origin_group_id  = azurerm_frontdoor_standard_origin_group.fd_origin_group[each.key].id
  enabled                    = true
  host_name                  = each.value.backend_host
  http_port                  = 80
  https_port                 = 443
  priority                   = 1
  weight                     = 50
}

resource "azurerm_frontdoor_standard_route" "fd_route" {
  for_each             = var.frontdoors
  name                 = "${each.value.name}-route"
  front_door_id        = azurerm_frontdoor_standard_profile.fd_profile[each.key].id
  frontend_endpoints   = [azurerm_frontdoor_standard_endpoint.fd_endpoint[each.key].id]
  patterns_to_match    = ["/*"]
  accepted_protocols   = ["Http", "Https"]
  forwarding_enabled   = true
  https_redirect_enabled = true
  link_to_default_domain = true
  origin_group_id      = azurerm_frontdoor_standard_origin_group.fd_origin_group[each.key].id
  forwarding_protocol  = "MatchRequest"
}
