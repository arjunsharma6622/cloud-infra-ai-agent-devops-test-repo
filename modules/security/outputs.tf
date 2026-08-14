output "key_vault_id" {
  value       = azurerm_key_vault.primary.id
  description = "The ID of the primary Key Vault."
}

output "managed_identity_id" {
  value       = azurerm_user_assigned_identity.automation.id
  description = "The ID of the user assigned managed identity."
}
