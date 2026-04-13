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
