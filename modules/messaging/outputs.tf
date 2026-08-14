output "servicebus_namespace_id" {
  value = {
    primary   = azurerm_servicebus_namespace.primary.id
    secondary = azurerm_servicebus_namespace.secondary.id
  }
}

output "eventhub_namespace_id" {
  value = azurerm_eventhub_namespace.primary.id
}

output "eventgrid_topic_id" {
  value = azurerm_eventgrid_topic.primary.id
}
