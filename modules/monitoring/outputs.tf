output "application_insights_key" {
  description = "The instrumentation key for Application Insights."
  value       = azurerm_application_insights.main.instrumentation_key
  sensitive   = true
}

output "application_insights_id" {
  description = "The ID of the Application Insights instance."
  value       = azurerm_application_insights.main.id
}

output "application_insights_connection_string" {
  description = "The connection string for Application Insights."
  value       = azurerm_application_insights.main.connection_string
  sensitive   = true
}

output "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.id
}

output "log_analytics_workspace_primary_shared_key" {
  description = "The primary shared key for the Log Analytics Workspace."
  value       = azurerm_log_analytics_workspace.main.primary_shared_key
  sensitive   = true
}
