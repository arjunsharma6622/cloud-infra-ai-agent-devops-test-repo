resource "azurerm_servicebus_namespace" "primary" {
  name                          = "sb-${var.environment}-${var.primary_region}"
  location                      = var.primary_region
  resource_group_name           = var.spoke_data_primary_rg_name
  sku                           = "Premium"
  capacity                      = 1
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
  tags                          = var.tags
}

resource "azurerm_servicebus_namespace" "secondary" {
  name                          = "sb-${var.environment}-${var.secondary_region}"
  location                      = var.secondary_region
  resource_group_name           = var.spoke_data_secondary_rg_name
  sku                           = "Premium"
  capacity                      = 1
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
  tags                          = var.tags
}

resource "azurerm_servicebus_queue" "claims" {
  name         = "sbq-claims"
  namespace_id = azurerm_servicebus_namespace.primary.id
}

resource "azurerm_eventgrid_topic" "primary" {
  name                          = "evg-${var.environment}-${var.primary_region}"
  location                      = var.primary_region
  resource_group_name           = var.spoke_data_primary_rg_name
  public_network_access_enabled = false
  tags                          = var.tags
}

resource "azurerm_eventhub_namespace" "primary" {
  name                          = "evhns-${var.environment}-${var.primary_region}"
  location                      = var.primary_region
  resource_group_name           = var.spoke_data_primary_rg_name
  sku                           = "Standard"
  capacity                      = 2
  auto_inflate_enabled          = true
  maximum_throughput_units      = 10
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
  tags                          = var.tags
}

resource "azurerm_eventhub" "telemetry" {
  name              = "evh-telemetry"
  namespace_id      = azurerm_eventhub_namespace.primary.id
  partition_count   = 4
  message_retention = 7
}

resource "azurerm_stream_analytics_job" "primary" {
  name                     = "asa-${var.environment}-${var.primary_region}"
  resource_group_name      = var.spoke_data_primary_rg_name
  location                 = var.primary_region
  compatibility_level      = "1.2"
  data_locale              = "en-US"
  streaming_units          = 3
  sku_name                 = "StandardV2"
  transformation_query     = "SELECT * INTO [YourOutputAlias] FROM [YourInputAlias]"
  tags                     = var.tags
}
