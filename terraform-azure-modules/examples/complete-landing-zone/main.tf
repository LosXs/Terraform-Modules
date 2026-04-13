module "tags" {
  source = "../../modules/_shared/tags"

  business_unit        = "IT"
  environment          = "Development"
  service              = "Monitoring"
  service_support_team = "IT"
  criticality          = "Important"
  exposure             = "Internal"
  additional_tags      = {}
}

module "naming" {
  source = "../../modules/_shared/naming"

  workload    = "landingzone"
  environment = "Development"
}

module "rg" {
  source = "../../modules/governance/resource-group"

  name     = module.naming.resource_group
  location = "uksouth"
  tags     = module.tags.tags
}

module "log_analytics" {
  source = "../../modules/monitoring/log-analytics-workspace"

  resource_group_name = module.rg.name
  location            = "uksouth"
  tags                = module.tags.tags
  name                = module.naming.log_analytics

  diagnostics_settings = null
}

module "vnet" {
  source = "../../modules/networking/virtual-network"

  resource_group_name = module.rg.name
  location            = "uksouth"
  tags                = module.tags.tags
  name                = module.naming.virtual_network
  address_space       = ["10.60.0.0/16"]

  diagnostics_settings = {
    log_analytics_workspace_id = module.log_analytics.id
  }
}

module "nsg" {
  source = "../../modules/networking/network-security-group"

  resource_group_name = module.rg.name
  location            = "uksouth"
  tags                = module.tags.tags
  name                = module.naming.nsg
  security_rules      = []

  diagnostics_settings = {
    log_analytics_workspace_id = module.log_analytics.id
  }
}

module "subnet" {
  source = "../../modules/networking/subnet"

  resource_group_name  = module.rg.name
  location             = "uksouth"
  tags                 = module.tags.tags
  name                 = module.naming.subnet
  virtual_network_name = module.vnet.name
  address_prefixes     = ["10.60.1.0/24"]

  diagnostics_settings = {
    log_analytics_workspace_id = module.log_analytics.id
  }
}

resource "azurerm_subnet_network_security_group_association" "main" {
  subnet_id                 = module.subnet.id
  network_security_group_id = module.nsg.id
}
