resource "azurerm_resource_group" "hub_primary" {
  name     = "rg-${var.environment}-hub-${var.primary_region}"
  location = var.primary_region
  tags     = var.tags
}

resource "azurerm_resource_group" "hub_secondary" {
  name     = "rg-${var.environment}-hub-${var.secondary_region}"
  location = var.secondary_region
  tags     = var.tags
}

resource "azurerm_resource_group" "spoke_primary" {
  name     = "rg-${var.environment}-spokes-${var.primary_region}"
  location = var.primary_region
  tags     = var.tags
}

resource "azurerm_resource_group" "spoke_secondary" {
  name     = "rg-${var.environment}-spokes-${var.secondary_region}"
  location = var.secondary_region
  tags     = var.tags
}

resource "azurerm_virtual_network" "hub_primary" {
  name                = "vnet-${var.environment}-hub-${var.primary_region}"
  location            = azurerm_resource_group.hub_primary.location
  resource_group_name = azurerm_resource_group.hub_primary.name
  address_space       = [var.hub_address_spaces[var.primary_region]]
  tags                = var.tags
}

resource "azurerm_virtual_network" "hub_secondary" {
  name                = "vnet-${var.environment}-hub-${var.secondary_region}"
  location            = azurerm_resource_group.hub_secondary.location
  resource_group_name = azurerm_resource_group.hub_secondary.name
  address_space       = [var.hub_address_spaces[var.secondary_region]]
  tags                = var.tags
}

resource "azurerm_subnet" "hub_fw_primary" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_primary.name
  virtual_network_name = azurerm_virtual_network.hub_primary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.primary_region][0]]
}

resource "azurerm_subnet" "hub_bastion_primary" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub_primary.name
  virtual_network_name = azurerm_virtual_network.hub_primary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.primary_region][1]]
}

resource "azurerm_subnet" "hub_gateway_primary" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_primary.name
  virtual_network_name = azurerm_virtual_network.hub_primary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.primary_region][2]]
}

resource "azurerm_subnet" "hub_fw_secondary" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.hub_secondary.name
  virtual_network_name = azurerm_virtual_network.hub_secondary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.secondary_region][0]]
}

resource "azurerm_subnet" "hub_bastion_secondary" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.hub_secondary.name
  virtual_network_name = azurerm_virtual_network.hub_secondary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.secondary_region][1]]
}

resource "azurerm_subnet" "hub_gateway_secondary" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.hub_secondary.name
  virtual_network_name = azurerm_virtual_network.hub_secondary.name
  address_prefixes     = [var.hub_subnet_prefixes[var.secondary_region][2]]
}

resource "azurerm_virtual_network" "spoke_app_primary" {
  name                = "vnet-${var.environment}-spoke-app-${var.primary_region}"
  location            = azurerm_resource_group.spoke_primary.location
  resource_group_name = azurerm_resource_group.spoke_primary.name
  address_space       = [var.spoke_address_spaces[var.primary_region].app]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_app_primary" {
  name                 = "snet-spoke-app"
  resource_group_name  = azurerm_resource_group.spoke_primary.name
  virtual_network_name = azurerm_virtual_network.spoke_app_primary.name
  address_prefixes     = [var.spoke_subnet_prefixes[var.primary_region].app]
}

resource "azurerm_virtual_network" "spoke_data_primary" {
  name                = "vnet-${var.environment}-spoke-data-${var.primary_region}"
  location            = azurerm_resource_group.spoke_primary.location
  resource_group_name = azurerm_resource_group.spoke_primary.name
  address_space       = [var.spoke_address_spaces[var.primary_region].data]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_data_primary" {
  name                              = "snet-spoke-data"
  resource_group_name               = azurerm_resource_group.spoke_primary.name
  virtual_network_name              = azurerm_virtual_network.spoke_data_primary.name
  address_prefixes                  = [var.spoke_subnet_prefixes[var.primary_region].data]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_virtual_network" "spoke_shared_primary" {
  name                = "vnet-${var.environment}-spoke-shared-${var.primary_region}"
  location            = azurerm_resource_group.spoke_primary.location
  resource_group_name = azurerm_resource_group.spoke_primary.name
  address_space       = [var.spoke_address_spaces[var.primary_region].shared]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_shared_primary" {
  name                              = "snet-spoke-shared"
  resource_group_name               = azurerm_resource_group.spoke_primary.name
  virtual_network_name              = azurerm_virtual_network.spoke_shared_primary.name
  address_prefixes                  = [var.spoke_subnet_prefixes[var.primary_region].shared]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_virtual_network" "spoke_app_secondary" {
  name                = "vnet-${var.environment}-spoke-app-${var.secondary_region}"
  location            = azurerm_resource_group.spoke_secondary.location
  resource_group_name = azurerm_resource_group.spoke_secondary.name
  address_space       = [var.spoke_address_spaces[var.secondary_region].app]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_app_secondary" {
  name                 = "snet-spoke-app"
  resource_group_name  = azurerm_resource_group.spoke_secondary.name
  virtual_network_name = azurerm_virtual_network.spoke_app_secondary.name
  address_prefixes     = [var.spoke_subnet_prefixes[var.secondary_region].app]
}

resource "azurerm_virtual_network" "spoke_data_secondary" {
  name                = "vnet-${var.environment}-spoke-data-${var.secondary_region}"
  location            = azurerm_resource_group.spoke_secondary.location
  resource_group_name = azurerm_resource_group.spoke_secondary.name
  address_space       = [var.spoke_address_spaces[var.secondary_region].data]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_data_secondary" {
  name                              = "snet-spoke-data"
  resource_group_name               = azurerm_resource_group.spoke_secondary.name
  virtual_network_name              = azurerm_virtual_network.spoke_data_secondary.name
  address_prefixes                  = [var.spoke_subnet_prefixes[var.secondary_region].data]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_virtual_network" "spoke_shared_secondary" {
  name                = "vnet-${var.environment}-spoke-shared-${var.secondary_region}"
  location            = azurerm_resource_group.spoke_secondary.location
  resource_group_name = azurerm_resource_group.spoke_secondary.name
  address_space       = [var.spoke_address_spaces[var.secondary_region].shared]
  tags                = var.tags
}

resource "azurerm_subnet" "spoke_shared_secondary" {
  name                              = "snet-spoke-shared"
  resource_group_name               = azurerm_resource_group.spoke_secondary.name
  virtual_network_name              = azurerm_virtual_network.spoke_shared_secondary.name
  address_prefixes                  = [var.spoke_subnet_prefixes[var.secondary_region].shared]
  private_endpoint_network_policies = "Disabled"
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_app_primary" {
  name                         = "peer-hub-to-app"
  resource_group_name          = azurerm_resource_group.hub_primary.name
  virtual_network_name         = azurerm_virtual_network.hub_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_app_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_app_to_hub_primary" {
  name                         = "peer-app-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_primary.name
  virtual_network_name         = azurerm_virtual_network.spoke_app_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_data_primary" {
  name                         = "peer-hub-to-data"
  resource_group_name          = azurerm_resource_group.hub_primary.name
  virtual_network_name         = azurerm_virtual_network.hub_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_data_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_data_to_hub_primary" {
  name                         = "peer-data-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_primary.name
  virtual_network_name         = azurerm_virtual_network.spoke_data_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_shared_primary" {
  name                         = "peer-hub-to-shared"
  resource_group_name          = azurerm_resource_group.hub_primary.name
  virtual_network_name         = azurerm_virtual_network.hub_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_shared_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_shared_to_hub_primary" {
  name                         = "peer-shared-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_primary.name
  virtual_network_name         = azurerm_virtual_network.spoke_shared_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_app_secondary" {
  name                         = "peer-hub-to-app"
  resource_group_name          = azurerm_resource_group.hub_secondary.name
  virtual_network_name         = azurerm_virtual_network.hub_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_app_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_app_to_hub_secondary" {
  name                         = "peer-app-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_secondary.name
  virtual_network_name         = azurerm_virtual_network.spoke_app_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_data_secondary" {
  name                         = "peer-hub-to-data"
  resource_group_name          = azurerm_resource_group.hub_secondary.name
  virtual_network_name         = azurerm_virtual_network.hub_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_data_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_data_to_hub_secondary" {
  name                         = "peer-data-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_secondary.name
  virtual_network_name         = azurerm_virtual_network.spoke_data_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "hub_to_spoke_shared_secondary" {
  name                         = "peer-hub-to-shared"
  resource_group_name          = azurerm_resource_group.hub_secondary.name
  virtual_network_name         = azurerm_virtual_network.hub_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke_shared_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke_shared_to_hub_secondary" {
  name                         = "peer-shared-to-hub"
  resource_group_name          = azurerm_resource_group.spoke_secondary.name
  virtual_network_name         = azurerm_virtual_network.spoke_shared_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "global_peering_primary_to_secondary" {
  name                         = "peer-hub-eastus2-to-westus3"
  resource_group_name          = azurerm_resource_group.hub_primary.name
  virtual_network_name         = azurerm_virtual_network.hub_primary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_secondary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "global_peering_secondary_to_primary" {
  name                         = "peer-hub-westus3-to-eastus2"
  resource_group_name          = azurerm_resource_group.hub_secondary.name
  virtual_network_name         = azurerm_virtual_network.hub_secondary.name
  remote_virtual_network_id    = azurerm_virtual_network.hub_primary.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
}

resource "azurerm_public_ip" "fw_primary" {
  name                = "pip-fw-${var.primary_region}"
  location            = azurerm_resource_group.hub_primary.location
  resource_group_name = azurerm_resource_group.hub_primary.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_public_ip" "fw_secondary" {
  name                = "pip-fw-${var.secondary_region}"
  location            = azurerm_resource_group.hub_secondary.location
  resource_group_name = azurerm_resource_group.hub_secondary.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_firewall" "primary" {
  name                = "fw-${var.primary_region}"
  location            = azurerm_resource_group.hub_primary.location
  resource_group_name = azurerm_resource_group.hub_primary.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_fw_primary.id
    public_ip_address_id = azurerm_public_ip.fw_primary.id
  }
}

resource "azurerm_firewall" "secondary" {
  name                = "fw-${var.secondary_region}"
  location            = azurerm_resource_group.hub_secondary.location
  resource_group_name = azurerm_resource_group.hub_secondary.name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Premium"
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_fw_secondary.id
    public_ip_address_id = azurerm_public_ip.fw_secondary.id
  }
}

resource "azurerm_public_ip" "bastion_primary" {
  name                = "pip-bastion-${var.primary_region}"
  location            = azurerm_resource_group.hub_primary.location
  resource_group_name = azurerm_resource_group.hub_primary.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_public_ip" "bastion_secondary" {
  name                = "pip-bastion-${var.secondary_region}"
  location            = azurerm_resource_group.hub_secondary.location
  resource_group_name = azurerm_resource_group.hub_secondary.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_bastion_host" "primary" {
  name                = "bastion-${var.primary_region}"
  location            = azurerm_resource_group.hub_primary.location
  resource_group_name = azurerm_resource_group.hub_primary.name
  sku                 = "Standard"
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_bastion_primary.id
    public_ip_address_id = azurerm_public_ip.bastion_primary.id
  }
}

resource "azurerm_bastion_host" "secondary" {
  name                = "bastion-${var.secondary_region}"
  location            = azurerm_resource_group.hub_secondary.location
  resource_group_name = azurerm_resource_group.hub_secondary.name
  sku                 = "Standard"
  tags                = var.tags

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.hub_bastion_secondary.id
    public_ip_address_id = azurerm_public_ip.bastion_secondary.id
  }
}

resource "azurerm_network_security_group" "spoke_app" {
  name                = "nsg-spoke-app"
  location            = azurerm_resource_group.spoke_primary.location
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags

  security_rule {
    name                       = "DenyAllInboundInternet"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "spoke_app_primary" {
  subnet_id                 = azurerm_subnet.spoke_app_primary.id
  network_security_group_id = azurerm_network_security_group.spoke_app.id
}

resource "azurerm_subnet_network_security_group_association" "spoke_app_secondary" {
  subnet_id                 = azurerm_subnet.spoke_app_secondary.id
  network_security_group_id = azurerm_network_security_group.spoke_app.id
}

resource "azurerm_route_table" "spoke_udr" {
  name                          = "udr-spoke-to-fw"
  location                      = azurerm_resource_group.spoke_primary.location
  resource_group_name           = azurerm_resource_group.spoke_primary.name
  bgp_route_propagation_enabled = true
  tags                          = var.tags

  route {
    name                   = "rt-default-to-fw"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.primary.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "spoke_app_primary" {
  subnet_id      = azurerm_subnet.spoke_app_primary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_subnet_route_table_association" "spoke_data_primary" {
  subnet_id      = azurerm_subnet.spoke_data_primary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_subnet_route_table_association" "spoke_shared_primary" {
  subnet_id      = azurerm_subnet.spoke_shared_primary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_subnet_route_table_association" "spoke_app_secondary" {
  subnet_id      = azurerm_subnet.spoke_app_secondary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_subnet_route_table_association" "spoke_data_secondary" {
  subnet_id      = azurerm_subnet.spoke_data_secondary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_subnet_route_table_association" "spoke_shared_secondary" {
  subnet_id      = azurerm_subnet.spoke_shared_secondary.id
  route_table_id = azurerm_route_table.spoke_udr.id
}

resource "azurerm_private_dns_zone" "sql" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "cosmos" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "redis" {
  name                = "privatelink.redis.cache.windows.net"
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "vault" {
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone" "blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.spoke_primary.name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_app_primary" {
  name                  = "link-sql-spoke-app-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_app_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_data_primary" {
  name                  = "link-sql-spoke-data-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_shared_primary" {
  name                  = "link-sql-spoke-shared-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_shared_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmos_spoke_data_primary" {
  name                  = "link-cosmos-spoke-data-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.cosmos.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_spoke_data_primary" {
  name                  = "link-redis-spoke-data-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.redis.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault_spoke_shared_primary" {
  name                  = "link-vault-spoke-shared-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.vault.id
  virtual_network_id    = azurerm_virtual_network.spoke_shared_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_spoke_data_primary" {
  name                  = "link-blob-spoke-data-primary"
  private_dns_zone_id   = azurerm_private_dns_zone.blob.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_primary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_app_secondary" {
  name                  = "link-sql-spoke-app-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_app_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_data_secondary" {
  name                  = "link-sql-spoke-data-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_spoke_shared_secondary" {
  name                  = "link-sql-spoke-shared-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.sql.id
  virtual_network_id    = azurerm_virtual_network.spoke_shared_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "cosmos_spoke_data_secondary" {
  name                  = "link-cosmos-spoke-data-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.cosmos.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis_spoke_data_secondary" {
  name                  = "link-redis-spoke-data-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.redis.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "vault_spoke_shared_secondary" {
  name                  = "link-vault-spoke-shared-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.vault.id
  virtual_network_id    = azurerm_virtual_network.spoke_shared_secondary.id
  registration_enabled  = false
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob_spoke_data_secondary" {
  name                  = "link-blob-spoke-data-secondary"
  private_dns_zone_id   = azurerm_private_dns_zone.blob.id
  virtual_network_id    = azurerm_virtual_network.spoke_data_secondary.id
  registration_enabled  = false
}
