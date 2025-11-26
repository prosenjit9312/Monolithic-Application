resource "azurerm_public_ip" "lb_pip" {
  for_each            = var.loadbalancers
  name                = "${each.value.name}-pip"
  location            = each.value.location
  resource_group_name = each.value.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "lb" {
  for_each            = var.loadbalancers
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontEnd"
    public_ip_address_id = azurerm_public_ip.lb_pip[each.key].id
  }
}