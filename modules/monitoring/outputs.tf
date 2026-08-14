output "log_analytics_workspace_id" {
  value = {
    primary   = azurerm_log_analytics_workspace.primary.id
    secondary = azurerm_log_analytics_workspace.secondary.id
  }
  description = "The ID of the Log Analytics Workspaces."
}

output "application_insights_id" {
  value = {
    primary   = azurerm_application_insights.primary.id
    secondary = azurerm_application_insights.secondary.id
  }
  description = "The ID of the Application Insights components."
}
