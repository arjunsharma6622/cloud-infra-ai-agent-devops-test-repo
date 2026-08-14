variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-integration-centralindia"
}

variable "location" {
  description = "The Azure region where APIM will be deployed."
  type        = string
  default     = "Central India"
}

variable "apim_name" {
  description = "The name of the API Management service."
  type        = string
  default     = "apim-prod-integration"
}

variable "publisher_name" {
  description = "The name of the publisher/company."
  type        = string
  default     = "Enterprise Integration"
}

variable "publisher_email" {
  description = "The email address of the publisher/company."
  type        = string
  default     = "admin@company.com"
}

variable "sku_name" {
  description = "The SKU and capacity of the API Management service (e.g., Premium_1)."
  type        = string
  default     = "Premium_1"
}

variable "subnet_ids" {
  description = "Map of subnet IDs from the network module."
  type        = map(string)
}

variable "zones" {
  description = "List of Availability Zones to deploy APIM into."
  type        = list(string)
  default     = ["1", "2", "3"]
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}