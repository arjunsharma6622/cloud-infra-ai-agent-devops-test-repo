variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  default     = "centralindia"
  description = "The Azure region for the resources."
}

variable "ssh_public_key" {
  type        = string
  sensitive   = true
  description = "The SSH public key for VM access."
}