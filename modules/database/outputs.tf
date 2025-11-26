output "mssql_server_ids" {
  value = { for k, v in azurerm_mssql_server.mssql : k => v.id }
}

output "mysql_server_ids" {
  value = { for k, v in azurerm_mysql_flexible_server.mysql : k => v.id }
}

output "postgresql_server_ids" {
  value = { for k, v in azurerm_postgresql_flexible_server.psql : k => v.id }
}
