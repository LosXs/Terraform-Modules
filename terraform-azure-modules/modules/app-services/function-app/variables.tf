variable "resource_group_name" {
  description = "Resource group for the function app."
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
  description = "Function app name (globally unique)."
  type        = string
}

variable "service_plan_id" {
  description = "App Service / Functions plan resource ID."
  type        = string
}

variable "storage_account_name" {
  description = "Storage account name for AzureWebJobsStorage."
  type        = string
}

variable "storage_account_access_key" {
  description = "Storage account primary access key."
  type        = string
  sensitive   = true
}

variable "https_only" {
  description = "Enforce HTTPS."
  type        = bool
  default     = true
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the function app."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
