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

  # Forwarding to a separate central workspace (e.g. Sentinel) can be enabled later by setting this object.
  diagnostics_settings = null
}
