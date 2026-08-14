variable "resource_group_name" {
  description = "Name of the resource group in which to create monitoring resources."
  type        = string
}

variable "location" {
  description = "Azure region for the resources."
  type        = string
  default     = "Central India"
}

variable "environment" {
  description = "Deployment environment (e.g. prod, qa)."
  type        = string
  default     = "prod"
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace. If omitted, a standard name will be constructed."
  type        = string
  default     = ""
}

variable "retention_in_days" {
  description = "Data retention period in days for Log Analytics and Application Insights."
  type        = number
  default     = 30
}

variable "application_insights_name" {
  description = "Name of the Application Insights resource. If omitted, a standard name will be constructed."
  type        = string
  default     = ""
}

variable "workbook_name" {
  description = "Display name of the Azure Monitor Operational Workbook."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A mapping of tags to assign to all resources."
  type        = map(string)
  default     = {}
}
