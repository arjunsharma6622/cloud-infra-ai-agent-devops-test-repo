variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure region for the resources."
  default     = "centralindia"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "address_space" {
  type        = string
  description = "The address space for the VNet."
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet."
}

variable "subnet_prefix" {
  type        = string
  description = "The address prefix for the subnet."
  default     = "10.0.1.0/24"
}

variable "nsg_name" {
  type        = string
  description = "The name of the network security group."
}