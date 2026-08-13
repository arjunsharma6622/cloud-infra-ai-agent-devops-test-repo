resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  vnet_name           = "foundation-vnet"
  subnet_name         = "internal-subnet"
  nsg_name            = "foundation-nsg"
}

module "monitoring" {
  source              = "./modules/monitoring"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  workspace_name      = "foundation-logs"
}

module "compute" {
  source                       = "./modules/compute"
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  subnet_id                    = module.network.subnet_id
  workspace_id                 = module.monitoring.workspace_id
  workspace_primary_shared_key = module.monitoring.workspace_primary_shared_key
  ssh_public_key               = var.ssh_public_key
}