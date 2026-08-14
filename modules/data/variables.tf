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

variable "spoke_data_primary_rg_name" {
  type        = string
  description = "Resource group name for primary data spoke"
  default     = "rg-prod-spokes-eastus2"
}

variable "spoke_data_secondary_rg_name" {
  type        = string
  description = "Resource group name for secondary data spoke"
  default     = "rg-prod-spokes-westus3"
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs"
}

variable "private_dns_zone_ids" {
  type        = map(string)
  description = "Map of private DNS zone IDs"
}

variable "key_vault_id" {
  type        = string
  description = "Key vault ID"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {}
}
