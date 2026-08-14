output "resource_group_name" {
  description = "The name of the resource group."
  value       = module.network.resource_group_name
}

output "vnet_id" {
  description = "The ID of the virtual network."
  value       = module.network.vnet_id
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs."
  value       = module.network.subnet_ids
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace."
  value       = module.monitoring.log_analytics_workspace_id
}

output "application_insights_id" {
  description = "The ID of the Application Insights instance."
  value       = module.monitoring.application_insights_id
}

output "user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity."
  value       = module.security.user_assigned_identity_id
}

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = module.security.key_vault_id
}

output "key_vault_uri" {
  description = "The URI of the Key Vault."
  value       = module.security.key_vault_uri
}

output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = module.storage.storage_account_id
}

output "storage_account_name" {
  description = "The name of the Storage Account."
  value       = module.storage.storage_account_name
}

output "servicebus_namespace_id" {
  description = "The ID of the Service Bus Namespace."
  value       = module.messaging.servicebus_namespace_id
}

output "servicebus_namespace_name" {
  description = "The name of the Service Bus Namespace."
  value       = module.messaging.servicebus_namespace_name
}

output "apim_id" {
  description = "The ID of the API Management service."
  value       = module.apim.apim_id
}

output "apim_name" {
  description = "The name of the API Management service."
  value       = module.apim.apim_name
}

output "apim_gateway_url" {
  description = "The Gateway URL of the API Management service."
  value       = module.apim.gateway_url
}

output "function_app_id" {
  description = "The ID of the Linux Function App."
  value       = module.compute.function_app_id
}

output "function_app_name" {
  description = "The name of the Linux Function App."
  value       = module.compute.function_app_name
}

output "logic_app_id" {
  description = "The ID of the Logic App Standard."
  value       = module.compute.logic_app_id
}

output "logic_app_name" {
  description = "The name of the Logic App Standard."
  value       = module.compute.logic_app_name
}