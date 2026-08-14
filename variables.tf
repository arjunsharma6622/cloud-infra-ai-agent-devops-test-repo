variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "Deployment environment (e.g., prod, qa)."
  type        = string
  default     = "prod"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-integration-centralindia"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "vnet-prod-integration-centralindia"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.200.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Map of subnet address prefixes."
  type        = map(string)
  default = {
    apim              = "10.200.1.0/24"
    integration       = "10.200.2.0/24"
    function          = "10.200.3.0/24"
    private_endpoints = "10.200.4.0/24"
    sap               = "10.200.5.0/24"
    management        = "10.200.6.0/24"
  }
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "kv-prod-integration-ci"
}

variable "storage_account_name" {
  description = "The name of the Storage Account."
  type        = string
  default     = "stprodintegrationdata"
}

variable "servicebus_namespace_name" {
  description = "The name of the Service Bus namespace."
  type        = string
  default     = "sb-prod-integration"
}

variable "apim_name" {
  description = "The name of the API Management service."
  type        = string
  default     = "apim-prod-integration"
}

variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
  default     = "func-prod-integration-engine"
}

variable "logic_app_name" {
  description = "The name of the Logic App Standard."
  type        = string
  default     = "logic-prod-workflows"
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}