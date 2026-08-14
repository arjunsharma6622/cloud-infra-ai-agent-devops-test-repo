variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-integration-centralindia"
}

variable "location" {
  description = "The Azure region where the storage account will be created."
  type        = string
  default     = "Central India"
}

variable "storage_account_name" {
  description = "The name of the Storage Account. Must be globally unique and lowercase alphanumeric."
  type        = string
  default     = "stprodintegrationdata"
}

variable "account_tier" {
  description = "Defines the Tier to use for this storage account (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_kind" {
  description = "Defines the Kind of account (e.g. StorageV2, BlockBlobStorage)."
  type        = string
  default     = "StorageV2"
}

variable "account_replication_type" {
  description = "Defines the type of replication to use (LRS, GRS, ZRS, etc.)."
  type        = string
  default     = "ZRS"
}

variable "subnet_ids" {
  description = "Map of subnet IDs from the network module."
  type        = map(string)
}

variable "containers" {
  description = "List of blob container names to create."
  type        = list(string)
  default = [
    "inbound",
    "outbound",
    "processed",
    "failed",
    "archive",
    "assembly",
    "partner-config",
    "reconciliation"
  ]
}

variable "tags" {
  description = "A mapping of tags to assign to the storage resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}