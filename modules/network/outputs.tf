output "resource_group_name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "The location of the resource group."
  value       = azurerm_resource_group.rg.location
}

output "vnet_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.vnet.id
}

output "vnet_name" {
  description = "The name of the virtual network."
  value       = azurerm_virtual_network.vnet.name
}

output "subnet_ids" {
  description = "Map of subnet names to subnet IDs."
  value = {
    apim              = azurerm_subnet.apim.id
    integration       = azurerm_subnet.integration.id
    function          = azurerm_subnet.function.id
    private_endpoints = azurerm_subnet.private_endpoints.id
    sap               = azurerm_subnet.sap.id
    management        = azurerm_subnet.management.id
  }
}

output "private_dns_zone_ids" {
  description = "Map of private DNS zone names to private DNS zone IDs."
  value       = { for k, v in azurerm_private_dns_zone.dns_zones : k => v.id }
}