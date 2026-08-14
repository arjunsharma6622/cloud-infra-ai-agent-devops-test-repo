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

variable "user_assigned_identity_name" {
  description = "The name of the User Assigned Identity."
  type        = string
  default     = "id-integration-prod"
}

variable "key_vault_name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "kv-prod-integration-ci"
}

variable "sku_name" {
  description = "The SKU name for Key Vault (standard or premium)."
  type        = string
  default     = "premium"
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted."
  type        = number
  default     = 90
}

variable "purge_protection_enabled" {
  description = "Is Purge Protection enabled for this Key Vault?"
  type        = bool
  default     = true
}

variable "enable_rbac_authorization" {
  description = "Specifies whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization."
  type        = bool
  default     = true
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed for this Key Vault."
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "Map of subnet names to subnet IDs."
  type        = map(string)
  default     = {}
}

variable "secrets" {
  description = "Map of secrets to populate in the Key Vault."
  type        = map(string)
  default = {
    "sap-client-id"     = "placeholder-sap-client-id"
    "sap-client-secret" = "placeholder-sap-client-secret"
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