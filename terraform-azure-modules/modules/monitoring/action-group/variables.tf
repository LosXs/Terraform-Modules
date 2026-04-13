variable "resource_group_name" {
  description = "Resource group for the action group."
  type        = string
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}

variable "name" {
  description = "Action group name."
  type        = string
}

variable "short_name" {
  description = "Short name up to 12 characters for SMS/compact UIs."
  type        = string
}

variable "email_receivers" {
  description = "At least one email receiver is required for a usable action group."
  type = list(object({
    name                    = string
    email_address           = string
    use_common_alert_schema = optional(bool, false)
  }))

  validation {
    condition     = length(var.email_receivers) > 0
    error_message = "Provide at least one email_receivers entry."
  }
}

variable "webhook_receivers" {
  description = "Optional webhook receivers."
  type = list(object({
    name                    = string
    service_uri             = string
    use_common_alert_schema = optional(bool, false)
  }))
  default = []
}
