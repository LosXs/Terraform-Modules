variable "resource_group_name" {
  description = "Resource group for the container registry."
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
  description = "Globally unique ACR name (alphanumeric only)."
  type        = string
}

variable "sku" {
  description = "Basic, Standard, or Premium."
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin user (prefer false and use RBAC)."
  type        = bool
  default     = false
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for ACR."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
