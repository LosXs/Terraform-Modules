variable "server_id" {
  description = "Azure SQL server resource ID."
  type        = string
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Database name."
  type        = string
}

variable "sku_name" {
  description = "SKU (e.g. S0, GP_S_Gen5_2, Basic)."
  type        = string
}

variable "collation" {
  description = "Optional collation."
  type        = string
  default     = null
}

variable "max_size_gb" {
  description = "Optional max size in GB."
  type        = number
  default     = null
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the database."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
