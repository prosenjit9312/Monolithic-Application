resource "azurerm_virtual_network" "vnet" {
  for_each = var.vnets

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  address_space       = each.value.address_space
tags                = each.value.tags
    private_endpoint_vnet_policies = coalesce(each.value.private_endpoint_vnet_policies, false) ? "Basic" : "Disabled"


  dynamic "subnet" {
    for_each = each.value.subnets
    content {
      name           = subnet.value.name
      address_prefixes = [subnet.value.address_prefix]

    }
  }
}