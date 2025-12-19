
module "resource_group" {
  source = "../../modules/resource-group"
  rgs = {
    rg1 = {
      name     = "Prosenjit-rg1"
      location = "centralindia"
      tags     = { owner = "prosenjit" }
    }
  }
}
module "vnet" {
  source     = "../../modules/network"
  depends_on = [module.resource_group]
  vnets = {
    vnet1 = {
      name          = "dev-vnet"
      rg_name       = "Prosenjit-rg"
      location      = "centralindia"
      address_space = ["10.3.0.0/16"]

      tags = { owner = "prosenjit" }
      subnets = [
        { name = "subnet1", address_prefix = "10.3.1.0/24" },
        { name = "subnet2", address_prefix = "10.3.2.0/24" },
        { name = "subnet3", address_prefix = "10.3.3.0/24" },
      ]
    }
  }
}

module "compute" {
  source = "../../modules/compute"
  depends_on = [ module.resource_group , module.vnet ]
  vms = {
    vm1 = {
      vm_name        = "dev-vm1"
      location       = "centralindia"
      rg_name        = "Prosenjit-rg"
      subnet_id      = "/subscriptions/6dbc33a2-5da4-4090-8ac2-b8dde7d2a834/resourceGroups/infra-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/subnet1"
      size           = "Standard_B1s"
      admin_username = "azureuser"
      ssh_key        = "~/.ssh/id_rsa.pub"
      os_disk_type   = "Standard_LRS"

      image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }

      tags = {
        owner = "prosenjit"
        env   = "dev"
      }
    }

    vm2 = {
      vm_name        = "dev-vm2"
      location       = "centralindia"
      rg_name        = "Prosenjit-rg"
      subnet_id      = "/subscriptions/6dbc33a2-5da4-4090-8ac2-b8dde7d2a834/resourceGroups/infra-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/subnet2"
      size           = "Standard_B1s"
      admin_username = "azureuser"
      ssh_key        = "~/.ssh/id_rsa.pub"
      os_disk_type   = "Standard_LRS"

      image = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
      }

      tags = {
        owner = "prosenjit"
        env   = "dev"
      }
    }
  }
}
module "database" {
  source = "../../modules/database"
  depends_on = [ module.resource_group ,module.vnet ]
  databases = {
    # --------------------------------------
    # 1️⃣ MSSQL DATABASE EXAMPLE
    # --------------------------------------
    db1 = {
      db_type        = "mssql"
      server_name    = "prosenjit-mssql-server"
      db_name        = "appdb1"
      rg_name        = "Prosenjit-rg"
      location       = "Central India"
      admin_user     = "sqladminuser"
      admin_password = "Admin@12345"
      sku_name       = "S0"
      max_size_gb    = 10
      subnet_id      = "/subscriptions/6dbc33a2-5da4-4090-8ac2-b8dde7d2a834/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/prosenjit-vnet/subnets/db-subnet"
      tags = {
        environment = "dev"
        owner       = "prosenjit"
      }
    }

    # --------------------------------------
    # 2️⃣ MYSQL FLEXIBLE SERVER EXAMPLE
    # --------------------------------------
    db2 = {
      db_type               = "mysql"
      server_name           = "prosenjit-mysql-server"
      db_name               = "foodappdb"
      rg_name               = "Prosenjit-rg"
      location              = "Central India"
      admin_user            = "mysqladmin"
      admin_password        = "MySQL@12345"
      sku_name              = "B_Standard_B1ms"
      version               = "8.0.21"
      backup_retention_days = 7
      subnet_id             = "/subscriptions/6dbc33a2-5da4-4090-8ac2-b8dde7d2a834/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/prosenjit-vnet/subnets/db-subnet"
      tags = {
        environment = "dev"
        project     = "food-delivery"
      }
    }
  }
}
module "frontdoor" {
  source = "../../modules/frontdoor"
depends_on = [ module.resource_group , module.vnet ]
  frontdoors = {
    fd1 = {
      name         = "prod-fd"
      rg_name      = "rg-network"
      location     = "Global"
      backend_host = "myapp-prod.azurewebsites.net"
      tags         = { env = "prod" }
    }

    fd2 = {
      name         = "dev-fd"
      rg_name      = "rg-network"
      location     = "Global"
      backend_host = "myapp-dev.azurewebsites.net"
    }
  }

}