# Management groups are a tenant-level hierarchy resource. They do not use resource_group_name or UK South location.

variable "name" {
  description = "Management group ID (alphanumeric, max 90 chars; often a short code)."
  type        = string
}

variable "display_name" {
  description = "Human-readable display name."
  type        = string
}

variable "parent_management_group_id" {
  description = "Parent management group resource ID (e.g. the tenant root group /providers/Microsoft.Management/managementGroups/{id})."
  type        = string
}

variable "subscription_ids" {
  description = "Optional list of subscription GUIDs to associate with this management group."
  type        = list(string)
  default     = []
}
