variable "resource_group_name" {
  description = "Resource group for the job."
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
  description = "Container app job name."
  type        = string
}

variable "container_app_environment_id" {
  description = "Container App Environment resource ID."
  type        = string
}

variable "replica_timeout_in_seconds" {
  description = "Replica timeout."
  type        = number
  default     = 1800
}

variable "replica_retry_limit" {
  description = "Retry limit per replica."
  type        = number
  default     = 1
}

variable "container_name" {
  description = "Container name."
  type        = string
}

variable "image" {
  description = "Container image."
  type        = string
}

variable "cpu" {
  description = "vCPU for the job container."
  type        = number
  default     = 0.25
}

variable "memory" {
  description = "Memory for the job container (e.g. 0.5Gi, 1Gi)."
  type        = string
  default     = "0.5Gi"
}

variable "manual_trigger_config" {
  description = "Used when schedule_trigger_config is null. Exactly one of manual or schedule trigger applies."
  type = object({
    parallelism              = optional(number, 1)
    replica_completion_count = optional(number, 1)
  })
  default = {}
}

variable "schedule_trigger_config" {
  description = "When set, the job runs on a cron schedule; manual_trigger_config is ignored."
  type = object({
    cron_expression          = string
    parallelism              = optional(number, 1)
    replica_completion_count = optional(number, 1)
  })
  default = null
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the job."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
