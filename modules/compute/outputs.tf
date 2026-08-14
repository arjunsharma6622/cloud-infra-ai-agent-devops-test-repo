output "function_service_plan_id" {
  description = "The ID of the Function App Service Plan."
  value       = azurerm_service_plan.function_plan.id
}

output "logic_service_plan_id" {
  description = "The ID of the Logic App Service Plan."
  value       = azurerm_service_plan.logic_plan.id
}

output "function_app_id" {
  description = "The ID of the Linux Function App."
  value       = azurerm_linux_function_app.function_app.id
}

output "function_app_name" {
  description = "The name of the Linux Function App."
  value       = azurerm_linux_function_app.function_app.name
}

output "function_app_default_hostname" {
  description = "The default hostname of the Linux Function App."
  value       = azurerm_linux_function_app.function_app.default_hostname
}

output "function_app_identity_principal_id" {
  description = "The System Assigned Principal ID of the Linux Function App."
  value       = azurerm_linux_function_app.function_app.identity[0].principal_id
}

output "logic_app_id" {
  description = "The ID of the Logic App Standard."
  value       = azurerm_logic_app_standard.logic_app.id
}

output "logic_app_name" {
  description = "The name of the Logic App Standard."
  value       = azurerm_logic_app_standard.logic_app.name
}

output "logic_app_default_hostname" {
  description = "The default hostname of the Logic App Standard."
  value       = azurerm_logic_app_standard.logic_app.default_hostname
}

output "logic_app_identity_principal_id" {
  description = "The System Assigned Principal ID of the Logic App Standard."
  value       = azurerm_logic_app_standard.logic_app.identity[0].principal_id
}