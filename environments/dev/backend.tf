terraform {
  backend "azurerm" {
    resource_group_name  = "Prosenjit-rg"
    storage_account_name = "dfkh012"
    container_name       = "infra-cnt"
    key                  = "dev.terraform.tfstate"
  }
}
