variable "resource_group_name" {
  description = "Name of the resource group for the virtual network."
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
  description = "Must be the output of the _shared/tags module. Must include all six mandatory organisational tags."
  type        = map(string)
}

variable "name" {
  description = "Virtual network name (typically from _shared/naming.virtual_network)."
  type        = string
}

variable "address_space" {
  description = "Address space CIDR blocks for the virtual network."
  type        = list(string)
}

variable "dns_servers" {
  description = "Optional custom DNS server IP addresses."
  type        = list(string)
  default     = null
}

variable "diagnostics_settings" {
  description = "When non-null, creates a diagnostic setting for the virtual network."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
