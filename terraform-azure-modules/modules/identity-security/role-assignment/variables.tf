# azurerm_role_assignment does not support Azure resource tags or location. Policy compliance is inherited from the scope resource.

variable "scope" {
  description = "The scope at which the Role Assignment applies (subscription, resource group, or resource ID)."
  type        = string
}

variable "principal_id" {
  description = "The ID of the principal (user, group, service principal, managed identity) to assign the role to."
  type        = string
}

variable "role_definition_name" {
  description = "Role name (e.g. Reader, Contributor). Use this OR role_definition_id."
  type        = string
  default     = null
}

variable "role_definition_id" {
  description = "Full role definition resource ID. Use this OR role_definition_name."
  type        = string
  default     = null
}

variable "description" {
  description = "Optional description for the role assignment (supported on newer API versions)."
  type        = string
  default     = null
}
