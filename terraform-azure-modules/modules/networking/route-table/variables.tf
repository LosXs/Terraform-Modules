variable "resource_group_name" {
  description = "Resource group for the route table."
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
  description = "Route table name (typically from _shared/naming.route_table)."
  type        = string
}

variable "bgp_route_propagation_enabled" {
  description = "When false, disables BGP route propagation for subnets associated with this route table (azurerm: bgp_route_propagation_enabled)."
  type        = bool
  default     = true
}

variable "routes" {
  description = "User-defined routes."
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  default = []
}

variable "diagnostics_settings" {
  description = "When non-null, creates a diagnostic setting for the route table."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
