resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsgs

  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name
  tags                = each.value.tags
}

# Ingress rules
resource "azurerm_network_security_rule" "ingress" {
  for_each = { for nsg_name, nsg in var.nsgs : 
               nsg_name => nsg.ingress_rules... 
               if length(nsg.ingress_rules) > 0 }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Inbound"
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}

# Egress rules
resource "azurerm_network_security_rule" "egress" {
  for_each = { for nsg_name, nsg in var.nsgs : 
               nsg_name => nsg.egress_rules... 
               if length(nsg.egress_rules) > 0 }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = "Outbound"
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = each.value.rg_name
  network_security_group_name = azurerm_network_security_group.nsg[each.key].name
}
