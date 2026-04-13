output "mandatory_tags" {
  description = "The six mandatory organisational tags using exact Azure Policy key names."
  value = {
    BusinessUnit       = var.business_unit
    Environment        = var.environment
    Service            = var.service
    ServiceSupportTeam = var.service_support_team
    Criticality        = var.criticality
    Exposure           = var.exposure
  }
}

output "tags" {
  description = "Mandatory tags merged with additional_tags, ready to assign to resources or resource groups."
  value = merge(
    {
      BusinessUnit       = var.business_unit
      Environment        = var.environment
      Service            = var.service
      ServiceSupportTeam = var.service_support_team
      Criticality        = var.criticality
      Exposure           = var.exposure
    },
    var.additional_tags,
  )
}
