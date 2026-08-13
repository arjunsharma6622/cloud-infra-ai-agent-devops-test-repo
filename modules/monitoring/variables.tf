variable "workspace_name" {
  description = "The name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "The Azure region for the workspace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}