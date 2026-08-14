data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "primary" {
  name                          = var.key_vault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "premium"
  soft_delete_retention_days    = 90
  purge_protection_enabled      = true
  rbac_authorization_enabled    = true
  public_network_access_enabled = false

  tags = var.tags
}

resource "azurerm_key_vault_secret" "example" {
  name         = "placeholder-secret"
  value        = "initial-placeholder-value"
  key_vault_id = azurerm_key_vault.primary.id
}

resource "azurerm_user_assigned_identity" "automation" {
  name                = var.managed_identity_name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_role_assignment" "automation_kv" {
  scope                = azurerm_key_vault.primary.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.automation.principal_id
}

resource "azurerm_automation_account" "main" {
  name                = var.automation_account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Basic"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.automation.id]
  }

  tags = var.tags
}
