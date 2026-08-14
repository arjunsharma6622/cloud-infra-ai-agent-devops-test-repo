output "vnet_ids" {
  value = {
    hub_primary      = azurerm_virtual_network.hub_primary.id
    hub_secondary    = azurerm_virtual_network.hub_secondary.id
    spoke_app_primary = azurerm_virtual_network.spoke_app_primary.id
    spoke_data_primary = azurerm_virtual_network.spoke_data_primary.id
    spoke_shared_primary = azurerm_virtual_network.spoke_shared_primary.id
    spoke_app_secondary = azurerm_virtual_network.spoke_app_secondary.id
    spoke_data_secondary = azurerm_virtual_network.spoke_data_secondary.id
    spoke_shared_secondary = azurerm_virtual_network.spoke_shared_secondary.id
  }
}

output "subnet_ids" {
  value = {
    hub_fw_primary      = azurerm_subnet.hub_fw_primary.id
    hub_bastion_primary = azurerm_subnet.hub_bastion_primary.id
    hub_gateway_primary = azurerm_subnet.hub_gateway_primary.id
    hub_fw_secondary    = azurerm_subnet.hub_fw_secondary.id
    hub_bastion_secondary = azurerm_subnet.hub_bastion_secondary.id
    hub_gateway_secondary = azurerm_subnet.hub_gateway_secondary.id
    spoke_app_primary   = azurerm_subnet.spoke_app_primary.id
    spoke_data_primary  = azurerm_subnet.spoke_data_primary.id
    spoke_shared_primary = azurerm_subnet.spoke_shared_primary.id
    spoke_app_secondary = azurerm_subnet.spoke_app_secondary.id
    spoke_data_secondary = azurerm_subnet.spoke_data_secondary.id
    spoke_shared_secondary = azurerm_subnet.spoke_shared_secondary.id
  }
}

output "private_dns_zone_ids" {
  value = {
    sql    = azurerm_private_dns_zone.sql.id
    cosmos = azurerm_private_dns_zone.cosmos.id
    redis  = azurerm_private_dns_zone.redis.id
    vault  = azurerm_private_dns_zone.vault.id
    blob   = azurerm_private_dns_zone.blob.id
  }
}
