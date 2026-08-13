variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  default     = "centralindia"
  description = "The Azure region for the resources."
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet where NICs will be attached."
}

variable "workspace_id" {
  type        = string
  description = "The ID of the Log Analytics workspace."
}

variable "workspace_primary_shared_key" {
  type        = string
  sensitive   = true
  description = "The primary shared key for the Log Analytics workspace."
}

variable "ssh_public_key" {
  type        = string
  description = "The SSH public key for VM access."
}