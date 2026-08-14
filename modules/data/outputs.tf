output "storage_account_ids" {
  value = {
    stgdatalake  = azurerm_storage_account.stgdatalake.id
    stgartifacts = azurerm_storage_account.stgartifacts.id
    stgeventhub  = azurerm_storage_account.stgeventhub.id
  }
}

output "mssql_server_id" {
  value = {
    primary   = azurerm_mssql_server.primary.id
    secondary = azurerm_mssql_server.secondary.id
  }
}

output "cosmosdb_account_id" {
  value = azurerm_cosmosdb_account.primary.id
}
