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

variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs from network module."
  type        = map(string)
  default     = {}
}

variable "application_insights_key" {
  description = "Instrumentation key for Application Insights."
  type        = string
  default     = ""
  sensitive   = true
}

variable "application_insights_connection_string" {
  description = "Connection string for Application Insights."
  type        = string
  default     = ""
  sensitive   = true
}

variable "user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity."
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "The ID of the primary storage account."
  type        = string
  default     = ""
}

variable "storage_account_name" {
  description = "The name of the storage account for Function App and Logic App runtime state."
  type        = string
  default     = "stprodintegrationdata"
}

variable "storage_account_access_key" {
  description = "The access key for the storage account."
  type        = string
  default     = ""
  sensitive   = true
}

variable "servicebus_namespace_id" {
  description = "The ID of the Service Bus Namespace."
  type        = string
  default     = ""
}

variable "function_service_plan_name" {
  description = "The name of the App Service Plan for Function Apps."
  type        = string
  default     = "asp-func-prod-integration"
}

variable "function_plan_sku" {
  description = "The SKU for the Function App Service Plan."
  type        = string
  default     = "EP2"
}

variable "logic_service_plan_name" {
  description = "The name of the App Service Plan for Logic Apps Standard."
  type        = string
  default     = "asp-logic-prod-workflows"
}

variable "logic_plan_sku" {
  description = "The SKU for the Logic App Service Plan."
  type        = string
  default     = "WS1"
}

variable "function_app_name" {
  description = "The name of the Linux Function App."
  type        = string
  default     = "func-prod-integration-engine"
}

variable "logic_app_name" {
  description = "The name of the Logic App Standard."
  type        = string
  default     = "logic-prod-workflows"
}

variable "function_app_settings" {
  description = "Additional app settings for the Linux Function App."
  type        = map(string)
  default     = {}
}

variable "logic_app_settings" {
  description = "Additional app settings for the Logic App Standard."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}