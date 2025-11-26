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
