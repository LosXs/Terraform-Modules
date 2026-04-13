variable "resource_group_name" {
  description = "Resource group for the PostgreSQL flexible server."
  type        = string
}

variable "location" {
  description = "Azure region. Enforced by Azure Policy: Restrict resources to UK South."
  type        = string
  default     = "uksouth"

  validation {
    condition     = var.location == "uksouth"
    error_message = "Azure Policy 'Restrict to UK South' enforces deployment to uksouth only. This value cannot be changed."
  }
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Server name (DNS prefix; globally unique)."
  type        = string
}

variable "postgresql_version" {
  description = "PostgreSQL major version."
  type        = string
  default     = "15"
}

variable "administrator_login" {
  description = "Administrator username."
  type        = string
}

variable "administrator_password" {
  description = "Administrator password."
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name (e.g. B_Standard_B1ms, GP_Standard_D2s_v3)."
  type        = string
}

variable "storage_mb" {
  description = "Storage size in MB."
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "Backup retention days."
  type        = number
  default     = 7
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the server."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
