resource "azurerm_servicebus_namespace" "sb" {
  name                          = var.servicebus_namespace_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.sku == "Premium" ? var.capacity : 0
  premium_messaging_partitions  = var.sku == "Premium" ? var.premium_messaging_partitions : 0
  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = var.public_network_access_enabled
  minimum_tls_version           = var.minimum_tls_version

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_servicebus_queue" "queues" {
  for_each     = toset(var.queues)
  name         = each.key
  namespace_id = azurerm_servicebus_namespace.sb.id

  max_delivery_count                   = 10
  dead_lettering_on_message_expiration = true
  batched_operations_enabled           = true
}

resource "azurerm_servicebus_topic" "topics" {
  for_each     = toset(var.topics)
  name         = each.key
  namespace_id = azurerm_servicebus_namespace.sb.id

  batched_operations_enabled = true
}

resource "azurerm_servicebus_subscription" "subscriptions" {
  for_each           = var.subscriptions
  name               = each.key
  topic_id           = azurerm_servicebus_topic.topics[each.value.topic_name].id
  max_delivery_count = each.value.max_delivery_count

  dead_lettering_on_message_expiration = true
  batched_operations_enabled           = true
}