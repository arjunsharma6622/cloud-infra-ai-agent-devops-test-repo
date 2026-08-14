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

variable "resource_group_name" {
  type        = string
  description = "Resource group name for monitoring resources"
  default     = "rg-prod-spokes-eastus2"
}

variable "mssql_server_id_primary" {
  type        = string
  description = "ID of the primary MSSQL server to monitor"
  default     = ""
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {
    CostCenter       = "CC-HEALTH-01"
    Environment      = "Production"
    DataClassification = "Confidential"
    Owner            = "PlatformEngineering"
  }
}
