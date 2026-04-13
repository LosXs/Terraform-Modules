variable "resource_group_name" {
  description = "Resource group for the VMSS."
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
  description = "VMSS name."
  type        = string
}

variable "sku" {
  description = "VM size for instances."
  type        = string
  default     = "Standard_B2s"
}

variable "instances" {
  description = "Number of VM instances."
  type        = number
  default     = 2
}

variable "admin_username" {
  description = "Linux admin username."
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key."
  type        = string
}

variable "subnet_id" {
  description = "Subnet for VMSS NICs."
  type        = string
}

variable "source_image" {
  description = "Source image reference."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the scale set."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
