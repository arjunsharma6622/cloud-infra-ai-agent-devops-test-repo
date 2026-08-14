resource "azurerm_log_analytics_workspace" "primary" {
  name                = "law-${var.environment}-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_log_analytics_workspace" "secondary" {
  name                = "law-${var.environment}-${var.secondary_region}"
  location            = var.secondary_region
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

resource "azurerm_application_insights" "primary" {
  name                = "appi-${var.environment}-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.primary.id
  application_type    = "web"
  tags                = var.tags
}

resource "azurerm_application_insights" "secondary" {
  name                = "appi-${var.environment}-${var.secondary_region}"
  location            = var.secondary_region
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.secondary.id
  application_type    = "web"
  tags                = var.tags
}

resource "azurerm_monitor_action_group" "main" {
  name                = "ag-${var.environment}-operations"
  resource_group_name = var.resource_group_name
  short_name          = "opsalerts"
  tags                = var.tags

  email_receiver {
    name          = "adminemail"
    email_address = "admin@meridianhealth.internal"
  }
}

resource "azurerm_monitor_metric_alert" "sql_dtu" {
  name                = "alert-${var.environment}-sql-dtu"
  resource_group_name = var.resource_group_name
  scopes              = [var.mssql_server_id_primary]
  description         = "Alerts when SQL DTU consumption is high"
  severity            = 2
  frequency           = "PT1M"
  window_size         = "PT5M"

  criteria {
    metric_namespace = "Microsoft.Sql/servers/databases"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.main.id
  }

  tags = var.tags
}
