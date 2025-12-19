# rgs = {
#   rg1 = {
#     name     = "infra-rg"
#     location = "central-india"

#   }
# }

# vnets= {
#   vnet1 = {
#     name          = "dev-vnet"
#     rg_name       = "Prosenjit-rg"
#     location      = "centralindia"
#     address_space = ["10.3.0.0/16"]

#     tags = {
#         tags = { project = "new-infra", owner = "prosenjit" }
#     }
#     subnets = [
#       { name = "subnet1", address_prefix = "10.3.1.0/24" },
#       { name = "subnet2", address_prefix = "10.3.2.0/24" },
#       { name = "subnet3", address_prefix = "10.3.3.0/24" },
#     ]
#   }
# }

# vms = {
#   web = {
#     vm_name        = "web-vm"
#     location       = "Central India"
#     rg_name        = "Prosenjit-rg"
#     subnet_id      = "/subscriptions/xxxx/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/vnet-dev/subnets/web"
#     ssh_key        = "~/.ssh/id_rsa.pub"
#     size           = "Standard_B2s"
#     admin_username = "azureuser"
#     os_disk_type   = "Standard_LRS"
#     tags = {
#       environment = "dev"
#       owner       = "prosenjit"
#     }
#     image = {
#       publisher = "Canonical"
#       offer     = "0001-com-ubuntu-server-jammy"
#       sku       = "22_04-lts"
#       version   = "latest"
#     }
#   }
# }

# databases = {
#   sql1 = {
#     db_type        = "mssql"
#     rg_name        = "rg-dev"
#     location       = "centralindia"
#     server_name    = "dev-sql-server"
#     db_name        = "devsqldb"
#     admin_user     = "sqladmin"
#     admin_password = "Password@123"
#     subnet_id      = "/subscriptions/xxx/resourceGroups/rg-dev/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/dbsubnet"
#   }

#   mysql1 = {
#     db_type        = "mysql"
#     rg_name        = "rg-dev"
#     location       = "centralindia"
#     server_name    = "dev-mysql-server"
#     db_name        = "mysqldb"
#     admin_user     = "mysqladmin"
#     admin_password = "Password@123"
#     subnet_id      = "/subscriptions/xxx/resourceGroups/rg-dev/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/dbsubnet"
#   }

#   psql1 = {
#     db_type        = "postgresql"
#     rg_name        = "rg-dev"
#     location       = "centralindia"
#     server_name    = "dev-psql-server"
#     db_name        = "pgdb"
#     admin_user     = "pgadmin"
#     admin_password = "Password@123"
#     subnet_id      = "/subscriptions/xxx/resourceGroups/rg-dev/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/dbsubnet"
#   }
# }

# appgateways = {
#   agw1 = {
#     name                      = "dev-appgw"
#     rg_name                   = "rg-dev"
#     location                  = "centralindia"
#     sku_name                  = "WAF_v2"
#     sku_tier                  = "WAF_v2"
#     capacity                  = 2
#     frontend_port             = 80
#     backend_port              = 8080
#     frontend_ip_config        = "frontendIP"
#     backend_pool_name         = "backendPool"
#     http_setting_name         = "httpSetting"
#     listener_name             = "appGatewayListener"
#     request_routing_rule_name = "rule1"
#     subnet_id                 = "..."
#     backend_ips               = []            # can be empty list if dynamic
#     tags                      = { environment = "dev" }
#   }
# }
