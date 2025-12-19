resource "azurerm_cdn_frontdoor_profile" "fd_profile" {
  for_each            = var.frontdoors
  name                = each.value.name
  resource_group_name = each.value.rg_name
  sku_name            = "Standard_AzureFrontDoor"
  tags                = lookup(each.value, "tags", {})
}

resource "azurerm_cdn_frontdoor_endpoint" "fd_endpoint" {
  for_each                    = var.frontdoors
  name                        = "${each.value.name}-endpoint"
  cdn_frontdoor_profile_id    = azurerm_cdn_frontdoor_profile.fd_profile[each.key].id
}

resource "azurerm_cdn_frontdoor_origin_group" "fd_org_grp" {
  for_each = var.frontdoors

  name                     = "${each.value.name}-og"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.fd_profile[each.key].id

  session_affinity_enabled = false

  load_balancing {
    sample_size                = 4
    successful_samples_required = 3
  }

  health_probe {
    interval_in_seconds = 30
    path                = "/"
    protocol            = "Http"  
    request_type        = "GET"
  }
}


resource "azurerm_cdn_frontdoor_origin" "fd_origin" {
  for_each                             = var.frontdoors
  name                                 = "${each.value.name}-origin"
  cdn_frontdoor_origin_group_id        = azurerm_cdn_frontdoor_origin_group.fd_org_grp[each.key].id
  enabled                              = true
  host_name                            = each.value.backend_host
  http_port                            = 80
  https_port                           = 443
  certificate_name_check_enabled       = false
}

resource "azurerm_cdn_frontdoor_route" "fd_route" {
  for_each                             = var.frontdoors
  name                                 = "${each.value.name}-route"
  cdn_frontdoor_endpoint_id            = azurerm_cdn_frontdoor_endpoint.fd_endpoint[each.key].id
  cdn_frontdoor_origin_group_id        = azurerm_cdn_frontdoor_origin_group.fd_org_grp[each.key].id
  cdn_frontdoor_origin_ids             = [azurerm_cdn_frontdoor_origin.fd_origin[each.key].id]

  patterns_to_match                    = ["/*"]
  supported_protocols = ["Http" , "Https"]

  https_redirect_enabled               = true
  forwarding_protocol                  = "MatchRequest"
  link_to_default_domain               = true
}
