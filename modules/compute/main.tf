resource "azurerm_container_registry" "primary" {
  name                          = "acr${var.environment}${var.primary_region}"
  resource_group_name           = var.spoke_shared_primary_rg_name
  location                      = var.primary_region
  sku                           = "Premium"
  admin_enabled                 = false
  public_network_access_enabled = false
  tags                          = var.tags
}

resource "azurerm_kubernetes_cluster" "primary" {
  name                      = "aks-${var.environment}-${var.primary_region}"
  location                  = var.primary_region
  resource_group_name       = var.spoke_app_primary_rg_name
  dns_prefix                = "aks-${var.environment}-${var.primary_region}"
  sku_tier                  = "Standard"
  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  azure_policy_enabled      = true

  default_node_pool {
    name                 = "systempool"
    node_count           = 2
    vm_size              = "Standard_DS2_v2"
    vnet_subnet_id       = var.subnet_ids["spoke_app_primary"]
    os_sku               = "AzureLinux"
    type                 = "VirtualMachineScaleSets"
    auto_scaling_enabled = true
    min_count            = 2
    max_count            = 5
  }

  node_provisioning_profile {
    mode = "Auto"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = "azure"
    network_data_plane = "azure"
    load_balancer_sku  = "standard"
    outbound_type      = "userDefinedRouting"
  }

  tags = var.tags
}

resource "azurerm_kubernetes_cluster_node_pool" "user_primary" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.primary.id
  vm_size               = "Standard_DS3_v2"
  node_count            = 3
  vnet_subnet_id        = var.subnet_ids["spoke_app_primary"]
  os_sku                = "AzureLinux"
  mode                  = "User"
  auto_scaling_enabled  = true
  min_count             = 3
  max_count             = 10
  tags                  = var.tags
}

resource "azurerm_service_plan" "primary" {
  name                = "asp-${var.environment}-${var.primary_region}"
  resource_group_name = var.spoke_app_primary_rg_name
  location            = var.primary_region
  os_type             = "Linux"
  sku_name            = "EP1"
  tags                = var.tags
}

resource "azurerm_linux_function_app" "claims_validation" {
  name                       = "func-${var.environment}-claims-${var.primary_region}"
  resource_group_name        = var.spoke_app_primary_rg_name
  location                   = var.primary_region
  service_plan_id            = azurerm_service_plan.primary.id
  storage_account_name       = var.storage_account_artifacts_name
  storage_account_access_key = var.storage_account_artifacts_key
  virtual_network_subnet_id  = var.subnet_ids["spoke_app_primary"]
  https_only                 = true

  site_config {
    application_stack {
      node_version = "20"
    }
    vnet_route_all_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  tags = var.tags
}

resource "azurerm_service_plan" "app_service_primary" {
  name                   = "asp-portal-${var.environment}-${var.primary_region}"
  resource_group_name    = var.spoke_app_primary_rg_name
  location               = var.primary_region
  os_type                = "Linux"
  sku_name               = "P1v3"
  worker_count           = 3
  zone_balancing_enabled = true
  tags                   = var.tags
}

resource "azurerm_linux_web_app" "admin_portal" {
  name                      = "app-admin-${var.environment}-${var.primary_region}"
  resource_group_name       = var.spoke_app_primary_rg_name
  location                  = var.primary_region
  service_plan_id           = azurerm_service_plan.app_service_primary.id
  virtual_network_subnet_id = var.subnet_ids["spoke_app_primary"]
  https_only                = true

  site_config {
    application_stack {
      node_version = "20-lts"
    }
    always_on              = true
    vnet_route_all_enabled = true
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine_scale_set" "batch_processing" {
  name                            = "vmss-${var.environment}-batch-${var.primary_region}"
  resource_group_name             = var.spoke_app_primary_rg_name
  location                        = var.primary_region
  sku                             = "Standard_D4_v5"
  instances                       = 2
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                           = "nic-vmss"
    primary                        = true
    accelerated_networking_enabled = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = var.subnet_ids["spoke_app_primary"]
    }
  }

  boot_diagnostics {}

  identity {
    type         = "UserAssigned"
    identity_ids = [var.managed_identity_id]
  }

  tags = var.tags
}
