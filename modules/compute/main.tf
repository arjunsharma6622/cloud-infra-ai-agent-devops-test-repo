resource "azurerm_service_plan" "function_plan" {
  name                         = var.function_service_plan_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  os_type                      = "Linux"
  sku_name                     = var.function_plan_sku
  maximum_elastic_worker_count = 20
  worker_count                 = 2

  tags = var.tags
}

resource "azurerm_service_plan" "logic_plan" {
  name                = var.logic_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Windows"
  sku_name            = var.logic_plan_sku
  worker_count        = 2

  tags = var.tags
}

resource "azurerm_linux_function_app" "function_app" {
  name                = var.function_app_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.function_plan.id

  storage_account_name          = var.storage_account_name
  storage_account_access_key    = var.storage_account_access_key != "" ? var.storage_account_access_key : null
  storage_uses_managed_identity = var.storage_account_access_key == "" ? true : null

  virtual_network_subnet_id = lookup(var.subnet_ids, "function", null)

  site_config {
    pre_warmed_instance_count = 2
    elastic_instance_minimum  = 2
    ftps_state                = "Disabled"
    minimum_tls_version       = "1.2"
    vnet_route_all_enabled    = true

    application_insights_key               = var.application_insights_key != "" ? var.application_insights_key : null
    application_insights_connection_string = var.application_insights_connection_string != "" ? var.application_insights_connection_string : null

    application_stack {
      python_version = "3.10"
    }
  }

  identity {
    type         = var.user_assigned_identity_id != "" ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.user_assigned_identity_id != "" ? [var.user_assigned_identity_id] : null
  }

  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME" = "python"
      "WEBSITE_RUN_FROM_PACKAGE" = "1"
    },
    var.function_app_settings
  )

  tags = var.tags
}

resource "azurerm_logic_app_standard" "logic_app" {
  name                       = var.logic_app_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_service_plan.logic_plan.id
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key

  virtual_network_subnet_id = lookup(var.subnet_ids, "integration", null)

  site_config {
    ftps_state                = "Disabled"
    min_tls_version           = "1.2"
    vnet_route_all_enabled    = true
    use_32_bit_worker_process = false
  }

  identity {
    type         = var.user_assigned_identity_id != "" ? "SystemAssigned, UserAssigned" : "SystemAssigned"
    identity_ids = var.user_assigned_identity_id != "" ? [var.user_assigned_identity_id] : null
  }

  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME"               = "node"
      "WEBSITE_NODE_DEFAULT_VERSION"           = "~18"
      "WEBSITE_RUN_FROM_PACKAGE"               = "1"
      "APPINSIGHTS_INSTRUMENTATIONKEY"         = var.application_insights_key
      "APPLICATIONINSIGHTS_CONNECTION_STRING" = var.application_insights_connection_string
    },
    var.logic_app_settings
  )

  tags = var.tags
}