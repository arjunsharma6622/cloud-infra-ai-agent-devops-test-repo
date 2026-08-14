resource "azurerm_mssql_server" "primary" {
  name                         = "sql-${var.environment}-${var.primary_region}"
  resource_group_name          = var.spoke_data_primary_rg_name
  location                     = var.primary_region
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd12345!"
  minimum_tls_version          = "1.2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_mssql_server" "secondary" {
  name                         = "sql-${var.environment}-${var.secondary_region}"
  resource_group_name          = var.spoke_data_secondary_rg_name
  location                     = var.secondary_region
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssw0rd12345!"
  minimum_tls_version          = "1.2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_mssql_database" "primary" {
  name           = "sqldb-${var.environment}"
  server_id      = azurerm_mssql_server.primary.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "BC_Gen5_4"
  zone_redundant = true

  long_term_retention_policy {
    yearly_retention = "P10Y"
  }

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_mssql_database" "secondary" {
  name           = "sqldb-${var.environment}"
  server_id      = azurerm_mssql_server.secondary.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  sku_name       = "BC_Gen5_4"
  zone_redundant = true

  tags = var.tags

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_mssql_failover_group" "example" {
  name      = "sqlfg-${var.environment}"
  server_id = azurerm_mssql_server.primary.id
  databases = [
    azurerm_mssql_database.primary.id
  ]

  partner_server {
    id = azurerm_mssql_server.secondary.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }

  tags = var.tags
}

resource "azurerm_cosmosdb_account" "primary" {
  name                = "cosmos-${var.environment}-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.spoke_data_primary_rg_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "Session"
  }

  geo_location {
    location          = var.primary_region
    failover_priority = 0
  }

  geo_location {
    location          = var.secondary_region
    failover_priority = 1
  }

  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "claims" {
  name                = "Claims"
  resource_group_name = var.spoke_data_primary_rg_name
  account_name        = azurerm_cosmosdb_account.primary.name
  throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "claims_container" {
  name                  = "Claims"
  resource_group_name   = var.spoke_data_primary_rg_name
  account_name          = azurerm_cosmosdb_account.primary.name
  database_name         = azurerm_cosmosdb_sql_database.claims.name
  partition_key_paths   = ["/id"]
  throughput            = 400
}

resource "azurerm_cosmosdb_sql_database" "alerts" {
  name                = "Alerts"
  resource_group_name = var.spoke_data_primary_rg_name
  account_name        = azurerm_cosmosdb_account.primary.name
  throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "alerts_container" {
  name                  = "Alerts"
  resource_group_name   = var.spoke_data_primary_rg_name
  account_name          = azurerm_cosmosdb_account.primary.name
  database_name         = azurerm_cosmosdb_sql_database.alerts.name
  partition_key_paths   = ["/id"]
  throughput            = 400
}

resource "azurerm_cosmosdb_sql_database" "auditlog" {
  name                = "AuditLog"
  resource_group_name = var.spoke_data_primary_rg_name
  account_name        = azurerm_cosmosdb_account.primary.name
  throughput          = 400
}

resource "azurerm_cosmosdb_sql_container" "auditlog_container" {
  name                  = "AuditLog"
  resource_group_name   = var.spoke_data_primary_rg_name
  account_name          = azurerm_cosmosdb_account.primary.name
  database_name         = azurerm_cosmosdb_sql_database.auditlog.name
  partition_key_paths   = ["/id"]
  throughput            = 400
}

resource "azurerm_redis_cache" "primary" {
  name                 = "redis-${var.environment}-${var.primary_region}"
  location             = var.primary_region
  resource_group_name  = var.spoke_data_primary_rg_name
  capacity             = 1
  family               = "P"
  sku_name             = "Premium"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  public_network_access_enabled = false
  subnet_id            = var.subnet_ids["spoke_data_primary"]

  redis_configuration {
  }

  tags = var.tags
}

resource "azurerm_redis_cache" "secondary" {
  name                 = "redis-${var.environment}-${var.secondary_region}"
  location             = var.secondary_region
  resource_group_name  = var.spoke_data_secondary_rg_name
  capacity             = 1
  family               = "P"
  sku_name             = "Premium"
  non_ssl_port_enabled = false
  minimum_tls_version  = "1.2"
  public_network_access_enabled = false
  subnet_id            = var.subnet_ids["spoke_data_secondary"]

  redis_configuration {
  }

  tags = var.tags
}

resource "azurerm_storage_account" "stgdatalake" {
  name                     = "stgdatalake${var.environment}"
  resource_group_name      = var.spoke_data_primary_rg_name
  location                 = var.primary_region
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = true
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_storage_container" "audit" {
  name                  = "audit"
  storage_account_id    = azurerm_storage_account.stgdatalake.id
  container_access_type = "private"
}

resource "azurerm_storage_management_policy" "stgdatalake" {
  storage_account_id = azurerm_storage_account.stgdatalake.id

  rule {
    name    = "lifecycle-rule"
    enabled = true
    filters {
      blob_types   = ["blockBlob"]
      prefix_match = ["audit/"]
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 90
        tier_to_archive_after_days_since_modification_greater_than = 365
      }
    }
  }
}

resource "azurerm_storage_account" "stgartifacts" {
  name                     = "stgartifacts${var.environment}"
  resource_group_name      = var.spoke_data_primary_rg_name
  location                 = var.primary_region
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_storage_account" "stgeventhub" {
  name                     = "stgeventhub${var.environment}"
  resource_group_name      = var.spoke_data_primary_rg_name
  location                 = var.primary_region
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind             = "StorageV2"
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_private_endpoint" "sql_primary" {
  name                = "pe-sql-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.spoke_data_primary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_primary"]

  private_service_connection {
    name                           = "psc-sql-${var.primary_region}"
    private_connection_resource_id = azurerm_mssql_server.primary.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-sql-${var.primary_region}"
    private_dns_zone_ids = [var.private_dns_zone_ids["sql"]]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "sql_secondary" {
  name                = "pe-sql-${var.secondary_region}"
  location            = var.secondary_region
  resource_group_name = var.spoke_data_secondary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_secondary"]

  private_service_connection {
    name                           = "psc-sql-${var.secondary_region}"
    private_connection_resource_id = azurerm_mssql_server.secondary.id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-sql-${var.secondary_region}"
    private_dns_zone_ids = [var.private_dns_zone_ids["sql"]]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "cosmos" {
  name                = "pe-cosmos-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.spoke_data_primary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_primary"]

  private_service_connection {
    name                           = "psc-cosmos-${var.primary_region}"
    private_connection_resource_id = azurerm_cosmosdb_account.primary.id
    subresource_names              = ["Sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-cosmos-${var.primary_region}"
    private_dns_zone_ids = [var.private_dns_zone_ids["cosmos"]]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "redis_primary" {
  name                = "pe-redis-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.spoke_data_primary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_primary"]

  private_service_connection {
    name                           = "psc-redis-${var.primary_region}"
    private_connection_resource_id = azurerm_redis_cache.primary.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-redis-${var.primary_region}"
    private_dns_zone_ids = [var.private_dns_zone_ids["redis"]]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "redis_secondary" {
  name                = "pe-redis-${var.secondary_region}"
  location            = var.secondary_region
  resource_group_name = var.spoke_data_secondary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_secondary"]

  private_service_connection {
    name                           = "psc-redis-${var.secondary_region}"
    private_connection_resource_id = azurerm_redis_cache.secondary.id
    subresource_names              = ["redisCache"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-redis-${var.secondary_region}"
    private_dns_zone_ids = [var.private_dns_zone_ids["redis"]]
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "stgdatalake" {
  name                = "pe-stgdatalake"
  location            = var.primary_region
  resource_group_name = var.spoke_data_primary_rg_name
  subnet_id           = var.subnet_ids["spoke_data_primary"]

  private_service_connection {
    name                           = "psc-stgdatalake"
    private_connection_resource_id = azurerm_storage_account.stgdatalake.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "pdzg-stgdatalake"
    private_dns_zone_ids = [var.private_dns_zone_ids["blob"]]
  }

  tags = var.tags
}
