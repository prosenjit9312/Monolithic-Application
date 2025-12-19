terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
  }
}
# terraform {
#   backend "azurerm" {
#     resource_group_name  = "Rg-prosenjit"
#     storage_account_name = "zqprosenjit1"
#     container_name       = "zqprosenjit1"
#     key                  = "dev.terraform.tfstate"
#   }
# }

provider "azurerm" {
  features {}
  subscription_id = "2fe6adb6-b639-4804-8d25-87b437c9cbe6"
}
