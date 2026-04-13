variable "resource_group_name" {
  description = "Resource group containing the virtual network."
  type        = string
}

variable "location" {
  description = "Region for policy alignment with the landing zone (subnet inherits the VNet region; must be uksouth)."
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
  description = "Subnet name (typically from _shared/naming.subnet)."
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the parent virtual network."
  type        = string
}

variable "address_prefixes" {
  description = "CIDR prefixes for this subnet."
  type        = list(string)
}

variable "service_endpoints" {
  description = "Optional service endpoints to enable on the subnet."
  type        = list(string)
  default     = []
}

variable "delegations" {
  description = "Optional subnet delegations (e.g. for App Service, AKS)."
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = optional(list(string), ["Microsoft.Network/virtualNetworks/subnets/action"])
    })
  }))
  default = []
}

variable "private_endpoint_network_policies" {
  description = "Private endpoint network policies setting (e.g. Enabled or Disabled)."
  type        = string
  default     = null
}

variable "private_link_service_network_policies_enabled" {
  description = "Whether private link service network policies are enabled."
  type        = bool
  default     = null
}

variable "diagnostics_settings" {
  description = "When non-null, creates a diagnostic setting for the subnet (if supported for the target API)."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
