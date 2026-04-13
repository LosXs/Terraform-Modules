variable "resource_group_name" {
  description = "Name of the resource group that will contain the Log Analytics workspace."
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
  description = "Must be the output of the _shared/tags module to ensure compliance with Azure Policy 'Resource Group - Required Tags'. Must include all six mandatory organisational tags."
  type        = map(string)
}

variable "name" {
  description = "Log Analytics workspace name (typically from the _shared/naming module)."
  type        = string
}

variable "sku" {
  description = "SKU for the workspace (e.g. PerGB2018)."
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Log retention period in days."
  type        = number
  default     = 30
}

variable "diagnostics_settings" {
  description = "When non-null, creates a diagnostic setting on this workspace forwarding logs/metrics to another Log Analytics workspace (e.g. central Sentinel). Leave null in most cases to avoid circular forwarding to the same workspace."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
