variable "resource_group_name" {
  description = "Resource group for the storage account."
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
  description = "Globally unique storage account name (lowercase alphanumeric only)."
  type        = string
}

variable "account_tier" {
  description = "Storage tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (e.g. LRS, GRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "Storage account kind."
  type        = string
  default     = "StorageV2"
}

variable "min_tls_version" {
  description = "Minimum TLS version."
  type        = string
  default     = "TLS1_2"
}

variable "https_traffic_only_enabled" {
  description = "Restrict to HTTPS only."
  type        = bool
  default     = true
}

variable "allow_nested_items_to_be_public" {
  description = "Allow nested items to be public (prefer false)."
  type        = bool
  default     = false
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the storage account."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
