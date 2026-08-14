terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "network" {
  source = "./modules/network"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_prefixes     = var.subnet_prefixes
  tags                = var.tags
}

module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = module.network.resource_group_name
  location            = var.location
  environment         = var.environment
  tags                = var.tags
}

module "security" {
  source = "./modules/security"

  resource_group_name = module.network.resource_group_name
  location            = var.location
  key_vault_name      = var.key_vault_name
  subnet_ids          = module.network.subnet_ids
  tags                = var.tags
}

module "storage" {
  source = "./modules/storage"

  resource_group_name  = module.network.resource_group_name
  location             = var.location
  storage_account_name = var.storage_account_name
  subnet_ids           = module.network.subnet_ids
  tags                 = var.tags
}

module "messaging" {
  source = "./modules/messaging"

  resource_group_name       = module.network.resource_group_name
  location                  = var.location
  servicebus_namespace_name = var.servicebus_namespace_name
  subnet_ids                = module.network.subnet_ids
  tags                      = var.tags
}

module "apim" {
  source = "./modules/apim"

  resource_group_name = module.network.resource_group_name
  location            = var.location
  apim_name           = var.apim_name
  subnet_ids          = module.network.subnet_ids
  tags                = var.tags
}

module "compute" {
  source = "./modules/compute"

  resource_group_name                     = module.network.resource_group_name
  location                                = var.location
  subnet_ids                              = module.network.subnet_ids
  application_insights_key                = module.monitoring.application_insights_key
  application_insights_connection_string = module.monitoring.application_insights_connection_string
  user_assigned_identity_id               = module.security.user_assigned_identity_id
  storage_account_id                      = module.storage.storage_account_id
  storage_account_name                    = module.storage.storage_account_name
  servicebus_namespace_id                 = module.messaging.servicebus_namespace_id
  function_app_name                       = var.function_app_name
  logic_app_name                          = var.logic_app_name
  tags                                    = var.tags
}