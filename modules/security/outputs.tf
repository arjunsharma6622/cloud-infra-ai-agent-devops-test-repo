output "user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.id
}

output "user_assigned_identity_principal_id" {
  description = "The Principal ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.principal_id
}

output "user_assigned_identity_client_id" {
  description = "The Client ID of the User Assigned Identity."
  value       = azurerm_user_assigned_identity.identity.client_id
}

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = azurerm_key_vault.kv.id
}

output "key_vault_name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.kv.name
}

output "key_vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.kv.vault_uri
}