output "apim_id" {
  description = "The ID of the API Management Service."
  value       = azurerm_api_management.apim.id
}

output "apim_name" {
  description = "The name of the API Management Service."
  value       = azurerm_api_management.apim.name
}

output "gateway_url" {
  description = "The URL of the Gateway for the API Management Service."
  value       = azurerm_api_management.apim.gateway_url
}

output "management_api_url" {
  description = "The URL for the Management API associated with this API Management Service."
  value       = azurerm_api_management.apim.management_api_url
}

output "developer_portal_url" {
  description = "The URL for the Developer Portal associated with this API Management Service."
  value       = azurerm_api_management.apim.developer_portal_url
}

output "private_ip_addresses" {
  description = "The Private IP addresses of the API Management Service."
  value       = azurerm_api_management.apim.private_ip_addresses
}

output "identity_principal_id" {
  description = "The Principal ID of the System-Assigned Managed Identity for API Management."
  value       = azurerm_api_management.apim.identity[0].principal_id
}