output "key_vault_id" {
  value       = module.security.key_vault_id
  description = "Primary Key Vault ID"
}

output "vnet_ids" {
  value       = module.network.vnet_ids
  description = "VNet IDs across regions"
}

output "mssql_server_ids" {
  value       = module.data.mssql_server_id
  description = "SQL Server IDs"
}

output "aks_cluster_id" {
  value       = module.compute.aks_cluster_id
  description = "Primary AKS Cluster ID"
}

output "front_door_id" {
  value       = module.ingress.front_door_id
  description = "Front Door ID"
}

output "log_analytics_workspace_id" {
  value       = module.monitoring.log_analytics_workspace_id
  description = "Log Analytics Workspace IDs"
}
