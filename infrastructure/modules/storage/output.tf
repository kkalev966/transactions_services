output "storage_account_name" {
  value       = azurerm_storage_account.example.name
  description = "The name of the storage account."
}

output "storage_container_name" {
  value       = azurerm_storage_container.example.name
  description = "The name of the storage container."
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.example.primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}
