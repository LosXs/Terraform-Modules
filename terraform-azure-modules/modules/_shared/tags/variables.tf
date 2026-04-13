variable "business_unit" {
  description = "Organisational business unit (Azure Policy tag BusinessUnit)."
  type        = string

  validation {
    condition     = contains(local.allowed_business_units, var.business_unit)
    error_message = "business_unit must be one of: ${join(", ", local.allowed_business_units)}"
  }
}

variable "environment" {
  description = "Environment name (Azure Policy tag Environment)."
  type        = string

  validation {
    condition     = contains(local.allowed_environments, var.environment)
    error_message = "environment must be one of: ${join(", ", local.allowed_environments)}"
  }
}

variable "service" {
  description = "Service or application name (Azure Policy tag Service)."
  type        = string

  validation {
    condition     = contains(local.allowed_services, var.service)
    error_message = "service must be one of: ${join(", ", local.allowed_services)}"
  }
}

variable "service_support_team" {
  description = "Owning support team (Azure Policy tag ServiceSupportTeam)."
  type        = string

  validation {
    condition     = contains(local.allowed_service_support_teams, var.service_support_team)
    error_message = "service_support_team must be one of: ${join(", ", local.allowed_service_support_teams)}"
  }
}

variable "criticality" {
  description = "Workload criticality (Azure Policy tag Criticality)."
  type        = string

  validation {
    condition     = contains(local.allowed_criticalities, var.criticality)
    error_message = "criticality must be one of: ${join(", ", local.allowed_criticalities)}"
  }
}

variable "exposure" {
  description = "Network/data exposure classification (Azure Policy tag Exposure)."
  type        = string

  validation {
    condition     = contains(local.allowed_exposures, var.exposure)
    error_message = "exposure must be one of: ${join(", ", local.allowed_exposures)}"
  }
}

variable "additional_tags" {
  description = "Optional extra tags merged after the six mandatory tags."
  type        = map(string)
  default     = {}
}
