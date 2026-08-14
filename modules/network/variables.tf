variable "environment" {
  type        = string
  description = "Environment name"
  default     = "prod"
}

variable "primary_region" {
  type        = string
  description = "Primary Azure region"
  default     = "eastus2"
}

variable "secondary_region" {
  type        = string
  description = "Secondary Azure region"
  default     = "westus3"
}

variable "hub_address_spaces" {
  type        = map(string)
  description = "Address spaces for hub VNets"
  default = {
    eastus2 = "10.0.0.0/16"
    westus3 = "10.1.0.0/16"
  }
}

variable "hub_subnet_prefixes" {
  type        = map(list(string))
  description = "Subnet prefixes for hub VNets (Firewall, Bastion, Gateway)"
  default = {
    eastus2 = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    westus3 = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  }
}

variable "spoke_address_spaces" {
  type        = map(map(string))
  description = "Address spaces for spoke VNets"
  default = {
    eastus2 = {
    app    = "10.10.0.0/16"
    data   = "10.11.0.0/16"
    shared = "10.12.0.0/16"
  }
  westus3 = {
    app    = "10.20.0.0/16"
    data   = "10.21.0.0/16"
    shared = "10.22.0.0/16"
  }
  }
}

variable "spoke_subnet_prefixes" {
  type        = map(map(string))
  description = "Subnet prefixes for spoke VNets"
  default = {
    eastus2 = {
    app    = "10.10.1.0/24"
    data   = "10.11.1.0/24"
    shared = "10.12.1.0/24"
  }
  westus3 = {
    app    = "10.20.1.0/24"
    data   = "10.21.1.0/24"
    shared = "10.22.1.0/24"
  }
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources"
  default = {
    CostCenter       = "CC-HEALTH-01"
    Environment      = "Production"
    DataClassification = "Confidential"
    Owner            = "PlatformEngineering"
  }
}
