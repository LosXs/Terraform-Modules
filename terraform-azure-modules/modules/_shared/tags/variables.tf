locals {
  # Single source of truth for Azure Policy "Required Tags" allowed values (update here when policy changes).
  allowed_business_units = [
    "AVM Team",
    "B2C",
    "Clients",
    "Customer Care",
    "Data (MI)",
    "Field Operations",
    "Field Operations B2C",
    "Field Operations Central Operations",
    "IT",
    "Procurement",
    "Risk & Audit",
  ]

  allowed_environments = [
    "Production",
    "Staging",
    "Test",
    "Development",
    "Disaster Recovery",
  ]

  allowed_services = [
    "Shared Services",
    "AD Management",
    "Affiliates",
    "Audit",
    "Autopilot",
    "AVM",
    "Azure Workstations",
    "Backup",
    "Certificate Services",
    "Cladding",
    "Cloudflare",
    "Cognos",
    "Complaints",
    "Compute Gateway",
    "CRM",
    "EDR",
    "Equipment Portal",
    "Fees",
    "File Repo",
    "Firewall",
    "FOS",
    "FTP",
    "HB terms",
    "Infrastructure Workstations",
    "KEP",
    "KMS",
    "M2L Discrepency",
    "MI Data Gateway",
    "MI System",
    "Monitoring",
    "NBCM",
    "Non-Trad API",
    "PAL",
    "PAM",
    "Patch Management",
    "Print Services",
    "Quest",
    "Risk Server",
    "RPA",
    "SIEM",
    "Surveyor Workstations",
    "Testing Automation",
    "Vulnerability Scanning",
    "WFS Terms",
  ]

  allowed_service_support_teams = [
    "IT",
    "AVM Team",
    "Business Solutions",
    "Data Connect",
    "Data (MI)",
  ]

  allowed_criticalities = [
    "Critical",
    "Important",
    "Low",
  ]

  allowed_exposures = [
    "Internal",
    "External",
    "Public",
  ]
}

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
