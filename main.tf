module "security" {
  source                  = "./modules/security"
  resource_group_name     = "rg-prod-spokes-eastus2"
  location                = "eastus2"
  key_vault_name          = "kv-prod-eastus2"
  managed_identity_name   = "id-prod-automation"
  automation_account_name = "aa-prod-operations"
  tags                    = var.tags
}

module "network" {
  source           = "./modules/network"
  environment      = var.environment
  primary_region   = var.primary_region
  secondary_region = var.secondary_region
  tags             = var.tags
}

module "data" {
  source                       = "./modules/data"
  environment                  = var.environment
  primary_region               = var.primary_region
  secondary_region             = var.secondary_region
  spoke_data_primary_rg_name   = "rg-prod-spokes-eastus2"
  spoke_data_secondary_rg_name = "rg-prod-spokes-westus3"
  subnet_ids                   = module.network.subnet_ids
  private_dns_zone_ids         = module.network.private_dns_zone_ids
  key_vault_id                 = module.security.key_vault_id
  tags                         = var.tags
}

module "messaging" {
  source                       = "./modules/messaging"
  environment                  = var.environment
  primary_region               = var.primary_region
  secondary_region             = var.secondary_region
  spoke_data_primary_rg_name   = "rg-prod-spokes-eastus2"
  spoke_data_secondary_rg_name = "rg-prod-spokes-westus3"
  subnet_ids                   = module.network.subnet_ids
  storage_account_ids          = module.data.storage_account_ids
  tags                         = var.tags
}

module "compute" {
  source                         = "./modules/compute"
  environment                    = var.environment
  primary_region                 = var.primary_region
  secondary_region               = var.secondary_region
  spoke_app_primary_rg_name      = "rg-prod-spokes-eastus2"
  spoke_shared_primary_rg_name   = "rg-prod-spokes-eastus2"
  subnet_ids                     = module.network.subnet_ids
  servicebus_namespace_id        = module.messaging.servicebus_namespace_id
  managed_identity_id            = module.security.managed_identity_id
  storage_account_artifacts_name = "stgartifactsprod"
  storage_account_artifacts_key  = ""
  tags                           = var.tags
}

module "ingress" {
  source                    = "./modules/ingress"
  environment               = var.environment
  primary_region            = var.primary_region
  secondary_region          = var.secondary_region
  spoke_app_primary_rg_name = "rg-prod-spokes-eastus2"
  spoke_app_secondary_rg_name = "rg-prod-spokes-westus3"
  subnet_ids                = module.network.subnet_ids
  tags                      = var.tags
}

module "monitoring" {
  source                  = "./modules/monitoring"
  environment             = var.environment
  primary_region          = var.primary_region
  secondary_region        = var.secondary_region
  resource_group_name     = "rg-prod-spokes-eastus2"
  mssql_server_id_primary = module.data.mssql_server_id.primary
  tags                    = var.tags
}
