resource "azurerm_web_application_firewall_policy" "primary" {
  name                = "waf-policy-${var.environment}-${var.primary_region}"
  resource_group_name = var.spoke_app_primary_rg_name
  location            = var.primary_region
  tags                = var.tags

  policy_settings {
    enabled            = true
    mode               = "Prevention"
    request_body_check = true
    file_upload_limit_in_mb = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"

      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = true
          action  = "Log"
        }
      }
    }
  }
}

resource "azurerm_public_ip" "agw_primary" {
  name                = "pip-agw-${var.environment}-${var.primary_region}"
  resource_group_name = var.spoke_app_primary_rg_name
  location            = var.primary_region
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_public_ip" "agw_secondary" {
  name                = "pip-agw-${var.environment}-${var.secondary_region}"
  resource_group_name = var.spoke_app_secondary_rg_name
  location            = var.secondary_region
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_application_gateway" "primary" {
  name                = "agw-${var.environment}-${var.primary_region}"
  resource_group_name = var.spoke_app_primary_rg_name
  location            = var.primary_region
  firewall_policy_id  = azurerm_web_application_firewall_policy.primary.id
  zones               = ["1", "2", "3"]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "gw-ip-config-primary"
    subnet_id = var.subnet_ids["spoke_app_primary"]
  }

  frontend_port {
    name = "fe-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "fe-ip-config"
    public_ip_address_id = azurerm_public_ip.agw_primary.id
  }

  backend_address_pool {
    name = "be-pool-default"
  }

  backend_http_settings {
    name                  = "be-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "fe-ip-config"
    frontend_port_name             = "fe-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "be-pool-default"
    backend_http_settings_name = "be-http-settings"
  }

  tags = var.tags
}

resource "azurerm_application_gateway" "secondary" {
  name                = "agw-${var.environment}-${var.secondary_region}"
  resource_group_name = var.spoke_app_secondary_rg_name
  location            = var.secondary_region
  firewall_policy_id  = azurerm_web_application_firewall_policy.primary.id
  zones               = ["1", "2", "3"]

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  autoscale_configuration {
    min_capacity = 2
    max_capacity = 10
  }

  gateway_ip_configuration {
    name      = "gw-ip-config-secondary"
    subnet_id = var.subnet_ids["spoke_app_secondary"]
  }

  frontend_port {
    name = "fe-port-80"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "fe-ip-config"
    public_ip_address_id = azurerm_public_ip.agw_secondary.id
  }

  backend_address_pool {
    name = "be-pool-default"
  }

  backend_http_settings {
    name                  = "be-http-settings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "fe-ip-config"
    frontend_port_name             = "fe-port-80"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "be-pool-default"
    backend_http_settings_name = "be-http-settings"
  }

  tags = var.tags
}

resource "azurerm_frontdoor" "primary" {
  name                = "afd-${var.environment}-meridian"
  resource_group_name = var.spoke_app_primary_rg_name

  routing_rule {
    name               = "routingRuleGeo"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontendEndpointPrimary"]

    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "backendPoolPrimary"
    }
  }

  backend_pool_load_balancing {
    name = "loadBalancingSettings"
  }

  backend_pool_health_probe {
    name = "healthProbeSettings"
  }

  backend_pool {
    name = "backendPoolPrimary"

    backend {
      host_header = azurerm_public_ip.agw_primary.ip_address
      address     = azurerm_public_ip.agw_primary.ip_address
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "loadBalancingSettings"
    health_probe_name   = "healthProbeSettings"
  }

  frontend_endpoint {
    name      = "frontendEndpointPrimary"
    host_name = "afd-${var.environment}-meridian.azurefd.net"
  }

  tags = var.tags
}

resource "azurerm_api_management" "primary" {
  name                = "apim-${var.environment}-${var.primary_region}"
  location            = var.primary_region
  resource_group_name = var.spoke_app_primary_rg_name
  publisher_name      = "MeridianHealth Platform"
  publisher_email     = "platform-ops@meridianhealth.internal"
  sku_name            = "Developer_1"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}
