terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.44.1"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "blob_rg" {
  name     = var.resource_group
  location = var.location

}

resource "azurerm_storage_account" "storage_account" {
  name                              = format("%s01byodstrg", lower(var.storagename))
  resource_group_name               = resource.azurerm_resource_group.blob_rg.name
  location                          = resource.azurerm_resource_group.blob_rg.location
  account_tier                      = var.tier
  account_replication_type          = var.accountreplicationtype
  min_tls_version                   = var.mintlsversion
  enable_https_traffic_only         = true
  infrastructure_encryption_enabled = true
  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }


  blob_properties {
    delete_retention_policy {
      days = 90
    }
  }

  allow_nested_items_to_be_public = false

  network_rules {

    default_action = "Deny"

    bypass = ["AzureServices"]

    ip_rules = ["49.37.73.43"]

    //virtual_network_subnet_ids = []

  }

  #tags = var.tags

}
resource "azurerm_advanced_threat_protection" "advanced_threat_protection" {
  target_resource_id = azurerm_storage_account.storage_account.id
  enabled            = true
}

resource "azurerm_storage_encryption_scope" "storage_encryption_scope" {
  name               = var.microsoftmanaged
  storage_account_id = azurerm_storage_account.storage_account.id
  source             = var.stgsource
}

resource "azurerm_storage_management_policy" "storage_management_policy" {
  storage_account_id = azurerm_storage_account.storage_account.id

  rule {
    name    = "rule1"
    enabled = true
    filters {
      blob_types = ["blockBlob"]
    }
    actions {

      snapshot {

        delete_after_days_since_creation_greater_than = 90
      }

    }
  }
}


resource "azurerm_storage_container" "storage_containers" {
  for_each              = toset(var.container_names)
  name                  = each.value
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

