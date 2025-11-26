# AzureBastionSubnet
resource "azurerm_subnet" "bastion_subnet" {
  for_each = var.bastions

  name                 = "BastionSubnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet_name
  address_prefixes     = [each.value.bastion_subnet_prefix]
}

# Public IP for Bastion
resource "azurerm_public_ip" "bastion_ip" {
  for_each = var.bastions

  name                = "${each.key}-pip"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"
}


# Azure Bastion Host
resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastions

  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "bastion-ip-config"
    subnet_id            = azurerm_subnet.bastion_subnet[each.key].id
    public_ip_address_id = azurerm_public_ip.bastion_ip[each.key].id
  }
}
