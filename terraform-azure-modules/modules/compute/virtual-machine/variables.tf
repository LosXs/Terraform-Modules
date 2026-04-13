variable "resource_group_name" {
  description = "Resource group for the VM and NIC."
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
  description = "Virtual machine name."
  type        = string
}

variable "nic_name" {
  description = "Network interface name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the NIC."
  type        = string
}

variable "size" {
  description = "VM SKU size."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Linux admin username."
  type        = string
}

variable "admin_ssh_public_key" {
  description = "SSH public key for admin access."
  type        = string
}

variable "os_disk_storage_account_type" {
  description = "OS disk storage account type."
  type        = string
  default     = "Premium_LRS"
}

variable "source_image" {
  description = "Source image reference for the Linux VM."
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
  description = "When non-null, diagnostic setting for the VM."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
