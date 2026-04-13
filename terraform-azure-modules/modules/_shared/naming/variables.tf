variable "workload" {
  description = "Short workload or project identifier (lowercase letters, digits, hyphens; max 12 characters)."
  type        = string

  validation {
    condition     = can(regex("^[-a-z0-9]{1,12}$", var.workload))
    error_message = "workload must be 1–12 characters: lowercase letters, digits, and hyphens only (e.g. my-app-01)."
  }
}

variable "environment" {
  description = "Logical environment; must match the tags module environment list."
  type        = string

  validation {
    condition     = contains(local.allowed_environments, var.environment)
    error_message = "environment must be one of: ${join(", ", local.allowed_environments)}"
  }
}

variable "location" {
  description = "Azure region for naming context. Enforced by Azure Policy to UK South for regional resources — only uksouth is accepted here."
  type        = string
  default     = "uksouth"

  validation {
    condition     = var.location == "uksouth"
    error_message = "location must be \"uksouth\" (Azure Policy: restrict resources to UK South)."
  }
}

variable "instance" {
  description = "Instance index; formatted as a three-digit suffix (001, 002, …)."
  type        = number
  default     = 1
}
