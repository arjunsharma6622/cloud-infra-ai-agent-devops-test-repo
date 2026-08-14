resource "azurerm_api_management" "apim" {
  name                = var.apim_name
  location            = var.location
  resource_group_name = var.resource_group_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  virtual_network_type = "Internal"

  virtual_network_configuration {
    subnet_id = var.subnet_ids["apim"]
  }

  zones = var.zones

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}