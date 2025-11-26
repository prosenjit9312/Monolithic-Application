key_vaults = {
  kv1 = {
    name       = "Prosenjit-keyvault"
    location   = "centralindia"
    rg_name    = "Prosenjit-rg"
    sku_name   = "standard"

    key_permissions = ["Get", "Create"]
    secret_permissions = ["Get", "Set", "Delete", "Purge"]

    tags = {
      environment = "Dev"
      owner       = "Prosenjit"
    }
  }
}

key_vault_secrets = {
  secret1 = {
    name      = "db-password"
    value     = "Devops@2025"
    vault_key = "kv1"
  }
  secret2 = {
    name      = "db-user-id"
    value     = "devops"
    vault_key = "kv1"
  }
}
