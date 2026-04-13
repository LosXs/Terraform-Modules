# Resource group scoped policy assignment. Tags/location follow the resource group; this assignment resource does not accept tags.

variable "name" {
  description = "Policy assignment name (Azure naming rules, max 64 characters)."
  type        = string
}

variable "resource_group_id" {
  description = "Resource ID of the resource group to assign the policy to."
  type        = string
}

variable "policy_definition_id" {
  description = "Resource ID of a policy definition or policy set definition to assign."
  type        = string
}

variable "description" {
  description = "Optional description."
  type        = string
  default     = null
}

variable "parameters" {
  description = "Optional JSON parameters for the policy assignment."
  type        = string
  default     = null
}

variable "enforce" {
  description = "Whether the policy is enforced."
  type        = bool
  default     = true
}
