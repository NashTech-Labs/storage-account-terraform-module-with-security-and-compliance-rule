output "storage" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_primary_access_key" {
  value     = azurerm_storage_account.storage_account.primary_access_key
  sensitive = true
}

output "container_names" {
   value = azurerm_storage_container.storage_containers.*
}
output "advanced_threat_protection" {
   value = azurerm_advanced_threat_protection.advanced_threat_protection
}
output "storage_management_policy" {
   value = azurerm_storage_management_policy.storage_management_policy
}
output "storage_encryption_scope" {
   value = azurerm_storage_encryption_scope.storage_encryption_scope
}
 


