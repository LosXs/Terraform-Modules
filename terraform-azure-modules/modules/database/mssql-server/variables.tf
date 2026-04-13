variable "resource_group_name" {
  description = "Resource group for the SQL server."
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
  description = "Azure SQL server name (globally unique DNS name)."
  type        = string
}

variable "sql_version" {
  description = "SQL Server version."
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "Administrator login name."
  type        = string
}

variable "administrator_login_password" {
  description = "Administrator password."
  type        = string
  sensitive   = true
}

variable "minimum_tls_version" {
  description = "Minimum TLS version."
  type        = string
  default     = "1.2"
}

variable "public_network_access_enabled" {
  description = "Whether public network access is allowed (prefer false with private endpoint)."
  type        = bool
  default     = false
}

variable "azuread_administrator" {
  description = "Optional Azure AD administrator block."
  type = object({
    login_username = string
    object_id      = string
  })
  default = null
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the SQL server."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
