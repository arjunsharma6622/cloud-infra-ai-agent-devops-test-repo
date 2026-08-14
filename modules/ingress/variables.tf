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

variable "spoke_app_secondary_rg_name" {
  type        = string
  description = "Resource group name for secondary app spoke"
  default     = "rg-prod-spokes-westus3"
}

variable "subnet_ids" {
  type        = map(string)
  description = "Map of subnet IDs"
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
