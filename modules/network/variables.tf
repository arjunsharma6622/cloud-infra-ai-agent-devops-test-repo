variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-prod-integration-centralindia"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "Central India"
}

variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
  default     = "vnet-prod-integration-centralindia"
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = list(string)
  default     = ["10.200.0.0/16"]
}

variable "subnet_prefixes" {
  description = "Map of subnet address prefixes."
  type        = map(string)
  default = {
    apim              = "10.200.1.0/24"
    integration       = "10.200.2.0/24"
    function          = "10.200.3.0/24"
    private_endpoints = "10.200.4.0/24"
    sap               = "10.200.5.0/24"
    management        = "10.200.6.0/24"
  }
}

variable "virtual_hub_id" {
  description = "The ID of the Virtual Hub for ExpressRoute Gateway (optional)."
  type        = string
  default     = null
}

variable "express_route_gateway_name" {
  description = "The name of the ExpressRoute Gateway."
  type        = string
  default     = "ergw-sap-connectivity"
}

variable "express_route_scale_units" {
  description = "The scale units for the ExpressRoute Gateway."
  type        = number
  default     = 1
}

variable "private_dns_zones" {
  description = "List of private DNS zone names to create."
  type        = list(string)
  default = [
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.servicebus.windows.net",
    "privatelink.azurewebsites.net"
  ]
}

variable "key_vault_id" {
  description = "The ID of the Key Vault for Private Endpoint creation (optional)."
  type        = string
  default     = null
}

variable "custom_dns_a_record_name" {
  description = "Name for custom Private DNS A record (optional)."
  type        = string
  default     = null
}

variable "custom_dns_a_record_ips" {
  description = "IP addresses for custom Private DNS A record."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to resources."
  type        = map(string)
  default = {
    environment = "production"
    owner       = "integration-team"
  }
}