variable "resource_group_name" {
  description = "Resource group name (required by azurerm_container_app)."
  type        = string
}

variable "location" {
  description = "Must be uksouth for policy alignment."
  type        = string
  default     = "uksouth"

  validation {
    condition     = var.location == "uksouth"
    error_message = "Azure Policy 'Restrict to UK South' enforces deployment to uksouth only."
  }
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Container app name."
  type        = string
}

variable "container_app_environment_id" {
  description = "Container App Environment resource ID."
  type        = string
}

variable "revision_mode" {
  description = "Single or Multiple."
  type        = string
  default     = "Single"
}

variable "container_name" {
  description = "Primary container name."
  type        = string
}

variable "image" {
  description = "Container image reference."
  type        = string
}

variable "cpu" {
  description = "CPU cores (e.g. 0.5)."
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "Memory (e.g. 1Gi)."
  type        = string
  default     = "1Gi"
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the container app."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
