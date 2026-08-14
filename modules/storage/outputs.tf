output "storage_account_id" {
  description = "The ID of the created storage account."
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the created storage account."
  value       = azurerm_storage_account.storage.name
}

output "primary_blob_endpoint" {
  description = "The primary blob endpoint URL of the storage account."
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "containers" {
  description = "Map of container names to container IDs."
  value       = { for k, v in azurerm_storage_container.containers : k => v.id }
}