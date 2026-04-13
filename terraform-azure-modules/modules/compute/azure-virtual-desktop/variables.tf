variable "resource_group_name" {
  description = "Resource group for AVD resources."
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

variable "host_pool_name" {
  description = "Host pool name."
  type        = string
}

variable "host_pool_type" {
  description = "Pooled or Personal."
  type        = string
  default     = "Pooled"

  validation {
    condition     = contains(["Pooled", "Personal"], var.host_pool_type)
    error_message = "host_pool_type must be Pooled or Personal."
  }
}

variable "load_balancer_type" {
  description = "BreadthFirst, DepthFirst, or Persistent for personal."
  type        = string
  default     = "BreadthFirst"
}

variable "validate_environment" {
  description = "Validate environment (test pools)."
  type        = bool
  default     = false
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the host pool."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
