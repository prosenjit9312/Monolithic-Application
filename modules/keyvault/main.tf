# Data source for Tenant Info
data "azurerm_client_config" "current" {}

# Key Vault Resource
resource "azurerm_key_vault" "keyvault" {
  for_each = var.key_vaults

  name                       = each.value.name
  location                   = each.value.location
  resource_group_name        = each.value.rg_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = each.value.sku_name
  soft_delete_retention_days = lookup(each.value, "soft_delete_retention_days", 7)

  # Default Access Policy (for current user)
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = lookup(each.value, "key_permissions", ["Get", "Create"])
    secret_permissions = lookup(each.value, "secret_permissions", ["Get", "Set", "Delete"])
  }

  tags = lookup(each.value, "tags", {})
}

# Key Vault Secrets Resource
resource "azurerm_key_vault_secret" "secrets" {
  for_each = var.key_vault_secrets

  name         = each.value.name
  value        = each.value.value
  key_vault_id = azurerm_key_vault.keyvault[each.value.vault_key].id
}
