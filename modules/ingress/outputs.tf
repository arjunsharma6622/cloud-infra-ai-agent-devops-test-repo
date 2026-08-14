output "application_gateway_ids" {
  value = {
    primary   = azurerm_application_gateway.primary.id
    secondary = azurerm_application_gateway.secondary.id
  }
  description = "IDs of the regional Application Gateways."
}

output "front_door_id" {
  value       = azurerm_frontdoor.primary.id
  description = "ID of the Azure Front Door instance."
}

output "api_management_id" {
  value       = azurerm_api_management.primary.id
  description = "ID of the API Management instance."
}
