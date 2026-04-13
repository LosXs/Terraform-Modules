variable "resource_group_name" {
  description = "Resource group for the Cosmos DB account."
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
  description = "Cosmos DB account name (globally unique, lowercase)."
  type        = string
}

variable "kind" {
  description = "GlobalDocumentDB, MongoDB, Parse, etc."
  type        = string
  default     = "GlobalDocumentDB"
}

variable "consistency_level" {
  description = "Cosmos consistency level."
  type        = string
  default     = "Session"
}

variable "enable_free_tier" {
  description = "Enable free tier if available."
  type        = bool
  default     = false
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the account."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
