variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-integration-centralindia"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "servicebus_namespace_name" {
  description = "The name of the Service Bus namespace."
  type        = string
  default     = "sb-prod-integration"
}

variable "sku" {
  description = "Defines which tier to use. Options are Basic, Standard or Premium."
  type        = string
  default     = "Premium"
}

variable "capacity" {
  description = "Messaging units for Premium SKU (1, 2, 4, 8, 16)."
  type        = number
  default     = 2
}

variable "premium_messaging_partitions" {
  description = "Specifies the number of messaging partitions for Premium SKU."
  type        = number
  default     = 1
}

variable "local_auth_enabled" {
  description = "Whether or not SAS authentication is enabled for the Service Bus namespace."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the Service Bus Namespace?"
  type        = bool
  default     = false
}

variable "minimum_tls_version" {
  description = "The minimum supported TLS version for this Service Bus Namespace."
  type        = string
  default     = "1.2"
}

variable "subnet_ids" {
  description = "Map of subnet IDs passed from the network module."
  type        = map(string)
  default     = {}
}

variable "queues" {
  description = "List of Service Bus queue names to create."
  type        = list(string)
  default = [
    "sbq-sap-po-inbound",
    "sbq-edi-po-inbound",
    "sbq-edi-invoice-inbound",
    "sbq-retry",
    "sbq-dead-letter"
  ]
}

variable "topics" {
  description = "List of Service Bus topic names to create."
  type        = list(string)
  default = [
    "sbt-integration-events"
  ]
}

variable "subscriptions" {
  description = "Map of topic subscriptions configuration."
  type = map(object({
    topic_name         = string
    max_delivery_count = number
  }))
  default = {
    "sub-sap-processing" = {
      topic_name         = "sbt-integration-events"
      max_delivery_count = 10
    }
    "sub-edi-processing" = {
      topic_name         = "sbt-integration-events"
      max_delivery_count = 10
    }
    "sub-audit-logger" = {
      topic_name         = "sbt-integration-events"
      max_delivery_count = 10
    }
  }
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}