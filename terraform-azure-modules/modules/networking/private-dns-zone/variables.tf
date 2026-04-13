# Private DNS zones are global resources; there is no UK South `location` on this resource.

variable "resource_group_name" {
  description = "Resource group that will contain the private DNS zone (metadata container)."
  type        = string
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Private DNS zone name (e.g. privatelink.blob.core.windows.net or a custom private zone)."
  type        = string
}

variable "soa_record" {
  description = "Optional SOA record block; leave null for Azure defaults."
  type = object({
    email        = optional(string)
    expire_time  = optional(number)
    minimum_ttl  = optional(number)
    refresh_time = optional(number)
    retry_time   = optional(number)
    ttl          = optional(number)
    tags         = optional(map(string))
  })
  default = null
}

variable "diagnostics_settings" {
  description = "When non-null, forwards metrics/logs to Log Analytics (if supported for this resource type)."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
