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

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default     = {
    CostCenter         = "CC-HEALTH-01"
    Environment        = "Production"
    DataClassification = "Confidential"
    Owner              = "PlatformEngineering"
  }
}
