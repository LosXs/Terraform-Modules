variable "resource_group_name" {
  description = "Resource group for the private endpoint."
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
  description = "Private endpoint name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet resource ID where the private endpoint NIC is placed."
  type        = string
}

variable "private_connection_resource_id" {
  description = "Resource ID of the target Azure service (e.g. storage, Key Vault)."
  type        = string
}

variable "subresource_names" {
  description = "Subresource name(s) for the private link (e.g. vault, blob, sqlServer)."
  type        = list(string)
}

variable "is_manual_connection" {
  description = "Whether the connection is manual approval."
  type        = bool
  default     = false
}

variable "private_connection_name" {
  description = "Name for the private_service_connection block."
  type        = string
}

variable "request_message" {
  description = "Optional request message for manual connections."
  type        = string
  default     = null
}

variable "private_dns_zone_group" {
  description = "Optional private DNS zone group configuration."
  type = object({
    name                 = string
    private_dns_zone_ids = list(string)
  })
  default = null
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the private endpoint."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
