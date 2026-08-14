variable "environment" {
  type        = string
  description = "Environment name"
  default     = "prod"
}

variable "primary_region" {
  type        = string
  description = "Primary Azure region"
  default     = "eastus2"
}

variable "secondary_region" {
  type        = string
  description = "Secondary Azure region"
  default     = "westus3"
}

variable "spoke_app_primary_rg_name" {
  type        = string
  description = "Resource group name for primary app spoke"
  default     = "rg-prod-spokes-eastus2"
}

variable "spoke_shared_primary_rg_name" {
  type        = string
  description = "Resource group name for primary shared spoke"
  default     = "rg-prod-spokes-eastus2"
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs"
}

variable "servicebus_namespace_id" {
  type        = map(string)
  description = "Map of Service Bus namespace IDs"
}

variable "managed_identity_id" {
  type        = string
  description = "ID of the user-assigned managed identity"
}

variable "storage_account_artifacts_name" {
  type        = string
  description = "Name of artifacts storage account"
  default     = "stgartifacts"
}

variable "storage_account_artifacts_key" {
  type        = string
  description = "Access key for artifacts storage account"
  sensitive   = true
  default     = ""
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key for VMSS instances"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQD0..."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    CostCenter         = "CC-HEALTH-01"
    Environment        = "Production"
    DataClassification = "Confidential"
    Owner              = "PlatformEngineering"
  }
}
