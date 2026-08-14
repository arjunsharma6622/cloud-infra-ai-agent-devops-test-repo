locals {
  workspace_name        = var.log_analytics_workspace_name != "" ? var.log_analytics_workspace_name : "log-${var.environment}-workspace"
  app_insights_name     = var.application_insights_name != "" ? var.application_insights_name : "appi-${var.environment}-integration"
  workbook_display_name = var.workbook_name != "" ? var.workbook_name : "workbook-integration-ops"
}

resource "azurerm_log_analytics_workspace" "main" {
  name                = local.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

resource "azurerm_application_insights" "main" {
  name                = local.app_insights_name
  location            = var.location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.main.id
  application_type    = "web"
  retention_in_days   = var.retention_in_days
  tags                = var.tags
}

resource "azurerm_application_insights_workbook" "ops" {
  name                = uuidv5("6ba7b810-9dad-11d1-80b4-00c04fd430c8", local.workbook_display_name)
  resource_group_name = var.resource_group_name
  location            = var.location
  display_name        = local.workbook_display_name
  data_json           = jsonencode({
    version = "Notebook/1.0"
    items = [
      {
        type = 1
        content = {
          json = "## Operational Integration Platform Dashboard\nMonitoring message volume, queue telemetry, latency metrics, and partner health."
        }
        name = "text_header"
      },
      {
        type = 3
        content = {
          version = 1
          query   = "requests | summarize count() by bin(timestamp, 1h), resultCode"
          size    = 1
          timeContext = {
            durationMs = 86400000
          }
          queryType    = 0
          resourceType = "microsoft.insights/components"
        }
        name = "request_metrics"
      }
    ]
    style = "categoryGrid"
  })
  tags = var.tags
}
