variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the security resources."
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Azure Key Vault."
}

variable "managed_identity_name" {
  type        = string
  description = "Name of the user assigned managed identity."
}

variable "automation_account_name" {
  type        = string
  description = "Name of the Azure Automation Account."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
