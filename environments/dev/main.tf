
module "resource_group" {
  source = "../../modules/resource-group"
  rgs = {
  rg1 = {
    name     = "infra-rg"
    location = "centralindia"
    tags     = { owner = "prosenjit" }
  }
}
}
module "vnet" {
  source = "../../modules/network"
  depends_on = [ module.resource_group ]
vnets= {
  vnet1 = {
    name          = "dev-vnet"
    rg_name       = "Prosenjit-rg"
    location      = "centralindia"
    address_space = ["10.3.0.0/16"]
    
    tags     = { owner = "prosenjit" }
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
  vms = {
  vm1 = {
    vm_name         = "dev-vm1"
    location        = "centralindia"
    rg_name         = "infra-rg"                         
    subnet_id       = "/subscriptions/xxxxxx/resourceGroups/infra-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/subnet1"
    size            = "Standard_B1s"
    admin_username  = "azureuser"
    ssh_key         = "~/.ssh/id_rsa.pub"                
    os_disk_type    = "Standard_LRS"

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
    vm_name         = "dev-vm2"
    location        = "centralindia"
    rg_name         = "infra-rg"
    subnet_id       = "/subscriptions/xxxxxx/resourceGroups/infra-rg/providers/Microsoft.Network/virtualNetworks/dev-vnet/subnets/subnet2"
    size            = "Standard_B1s"
    admin_username  = "azureuser"
    ssh_key         = "~/.ssh/id_rsa.pub"
    os_disk_type    = "Standard_LRS"

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
    subnet_id      = "/subscriptions/xxxxxx/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/prosenjit-vnet/subnets/db-subnet"
    tags = {
      environment = "dev"
      owner       = "prosenjit"
    }
  }

  # --------------------------------------
  # 2️⃣ MYSQL FLEXIBLE SERVER EXAMPLE
  # --------------------------------------
  db2 = {
    db_type        = "mysql"
    server_name    = "prosenjit-mysql-server"
    db_name        = "foodappdb"
    rg_name        = "Prosenjit-rg"
    location       = "Central India"
    admin_user     = "mysqladmin"
    admin_password = "MySQL@12345"
    sku_name       = "B_Standard_B1ms"
    version        = "8.0.21"
    backup_retention_days = 7
    subnet_id      = "/subscriptions/xxxxxx/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/prosenjit-vnet/subnets/db-subnet"
    tags = {
      environment = "dev"
      project     = "food-delivery"
    }
  }

  # --------------------------------------
  # 3️⃣ POSTGRESQL FLEXIBLE SERVER EXAMPLE
  # --------------------------------------
  db3 = {
    db_type        = "postgresql"
    server_name    = "prosenjit-psql-server"
    db_name        = "schoolmgmdb"
    rg_name        = "Prosenjit-rg"
    location       = "Central India"
    admin_user     = "psqladmin"
    admin_password = "Postgres@12345"
    sku_name       = "B_Standard_B1ms"
    version        = "14"
    backup_retention_days = 7
    subnet_id      = "/subscriptions/xxxxxx/resourceGroups/Prosenjit-rg/providers/Microsoft.Network/virtualNetworks/prosenjit-vnet/subnets/db-subnet"
    tags = {
      environment = "dev"
      project     = "school-management"
    }
  }
}


}
module "frontdoor" {
  source = "../../modules/frontdoor"

frontdoors = {
  fd1 = {
    name         = "prosenjit-frontdoor-dev"
    rg_name      = "Prosenjit-rg"
    location     = "Central India"
    backend_host = "app-dev.prosenjit.in"
    tags = {
      environment = "dev"
      owner       = "prosenjit"
    }
  }

  fd2 = {
    name         = "prosenjit-frontdoor-prod"
    rg_name      = "Prosenjit-rg"
    location     = "Central India"
    backend_host = "app-prod.prosenjit.in"
    tags = {
      environment = "prod"
      owner       = "prosenjit"
    }
  }
}
}


module "bastion" {
  source = "../../modules/basion"

bastions = {
  bastion1 = {
    location              = "centralindia"
    resource_group_name   = "Prosenjit-rg"
    vnet_name             = "vnet-main"
    bastion_subnet_prefix = "10.0.2.0/24"
  }

  bastion2 = {
    location              = "eastus"
    resource_group_name   = "Prosenjit-rg"
    vnet_name             = "vnet-prod"
    bastion_subnet_prefix = "10.10.2.0/24"
  }
}
}