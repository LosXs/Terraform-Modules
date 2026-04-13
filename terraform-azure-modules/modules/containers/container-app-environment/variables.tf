variable "resource_group_name" {
  description = "Resource group for the Container Apps environment."
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
  description = "Container Apps environment name."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics workspace resource ID for environment logging."
  type        = string
}

variable "diagnostics_settings" {
  description = "When non-null, additional diagnostic setting (optional; LAW is already wired for Container Apps)."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
