variable "name" {
  description = "Resource group name (typically from the _shared/naming module output)."
  type        = string
}

variable "location" {
  description = "Azure region for the resource group. Enforced by Azure Policy: Restrict resources to UK South."
  type        = string
  default     = "uksouth"

  validation {
    condition     = var.location == "uksouth"
    error_message = "Azure Policy 'Restrict to UK South' enforces deployment to uksouth only. This value cannot be changed."
  }
}

variable "tags" {
  description = "Must be the output of the _shared/tags module to ensure compliance with Azure Policy 'Resource Group - Required Tags'. Must include all six mandatory organisational tags."
  type        = map(string)
}
