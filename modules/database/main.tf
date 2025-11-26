# -----------------------------
# MSSQL SERVER & DATABASE
# -----------------------------
resource "azurerm_mssql_server" "mssql" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "mssql" }

  name                         = each.value.server_name
  resource_group_name          = each.value.rg_name
  location                     = each.value.location
  version                      = "12.0"
  administrator_login          = each.value.admin_user
  administrator_login_password = each.value.admin_password
}

resource "azurerm_mssql_database" "mssql_db" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "mssql" }

  name           = each.value.db_name
  server_id      = azurerm_mssql_server.mssql[each.key].id
  sku_name       = lookup(each.value, "sku_name", "Basic")
  max_size_gb    = lookup(each.value, "max_size_gb", 10)
  zone_redundant = false
}

resource "azurerm_mssql_virtual_network_rule" "mssql_vnet_rule" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "mssql" }

  name      = "${each.value.server_name}-vnet-rule"
  server_id = azurerm_mssql_server.mssql[each.key].id
  subnet_id = each.value.subnet_id
  ignore_missing_vnet_service_endpoint = false
}

# -----------------------------
# MYSQL FLEXIBLE SERVER & DATABASE
# -----------------------------
resource "azurerm_mysql_flexible_server" "mysql" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "mysql" }

  name                = each.value.server_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  administrator_login = each.value.admin_user
  administrator_password = each.value.admin_password
  sku_name            = lookup(each.value, "sku_name", "B_Standard_B1ms")
  version             = lookup(each.value, "version", "8.0.21")
  backup_retention_days = lookup(each.value, "backup_retention_days", 7)
  delegated_subnet_id = each.value.subnet_id

  tags = each.value.tags
}

# -----------------------------
# POSTGRESQL FLEXIBLE SERVER & DATABASE
# -----------------------------
resource "azurerm_postgresql_flexible_server" "psql" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "postgresql" }

  name                = each.value.server_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  administrator_login = each.value.admin_user
  administrator_password = each.value.admin_password
  sku_name            = lookup(each.value, "sku_name", "B_Standard_B1ms")
  storage_mb          = lookup(each.value, "storage_mb", 32768)
  version             = lookup(each.value, "version", "14")
  backup_retention_days = lookup(each.value, "backup_retention_days", 7)
  delegated_subnet_id = each.value.subnet_id

  tags = each.value.tags
}

resource "azurerm_postgresql_flexible_server_database" "psql_db" {
  for_each = { for k, v in var.databases : k => v if lower(v.db_type) == "postgresql" }

  name      = each.value.db_name
  server_id = azurerm_postgresql_flexible_server.psql[each.key].id
  charset   = "UTF8"
  collation = "C"
}
