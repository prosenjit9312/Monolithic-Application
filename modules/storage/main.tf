resource "azurerm_storage_account" "storageaccountname" {
    for_each = var.stgs
  name                     = each.value.name
  resource_group_name      = each.value.rg_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type
public_network_access_enabled = each.value.public_network_access_enabled
 
  tags = {
    environment = each.value.name
  }
  }
