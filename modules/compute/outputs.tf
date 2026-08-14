output "compute_identity_ids" {
  value = {
    aks_principal_id      = azurerm_kubernetes_cluster.primary.identity[0].principal_id
    function_principal_id = azurerm_linux_function_app.claims_validation.identity[0].principal_id
    webapp_principal_id   = azurerm_linux_web_app.admin_portal.identity[0].principal_id
    vmss_principal_id     = azurerm_linux_virtual_machine_scale_set.batch_processing.identity[0].principal_id
  }
  description = "Principal IDs of compute resources for role assignments."
}

output "container_registry_id" {
  value       = azurerm_container_registry.primary.id
  description = "The ID of the Azure Container Registry"
}

output "aks_cluster_id" {
  value       = azurerm_kubernetes_cluster.primary.id
  description = "The ID of the primary AKS cluster"
}
