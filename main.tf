terraform {
  required_version = ">= 1.15.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.14"
    }
  }
}

# Uses your Azure CLI sign-in and its default subscription.
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "forecast" {
  name     = "rg-brezyweather-forecast-drift"
  location = "eastus2"
}

# Forecast API data storage. The name gets a short suffix from the
# resource group ID so it's globally unique.
resource "azurerm_storage_account" "forecast_data" {
  name                     = "stbwfcdata${substr(sha1(azurerm_resource_group.forecast.id), 0, 8)}"
  resource_group_name      = azurerm_resource_group.forecast.name
  location                 = azurerm_resource_group.forecast.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    environment = "prod"
    managedBy   = "terraform"
  }
}

output "storage_account_name" {
  value = azurerm_storage_account.forecast_data.name
}
