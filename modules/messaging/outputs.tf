output "servicebus_namespace_id" {
  description = "The ID of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.sb.id
}

output "servicebus_namespace_name" {
  description = "The name of the Service Bus Namespace."
  value       = azurerm_servicebus_namespace.sb.name
}

output "servicebus_queue_ids" {
  description = "Map of queue names to queue IDs."
  value       = { for k, v in azurerm_servicebus_queue.queues : k => v.id }
}

output "servicebus_topic_ids" {
  description = "Map of topic names to topic IDs."
  value       = { for k, v in azurerm_servicebus_topic.topics : k => v.id }
}