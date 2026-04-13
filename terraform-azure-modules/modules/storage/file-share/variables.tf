variable "storage_account_id" {
  description = "Resource ID of the storage account."
  type        = string
}

variable "tags" {
  description = "Must be the output of the _shared/tags module (for stack consistency; not applied to azurerm_storage_share)."
  type        = map(string)
}

variable "name" {
  description = "File share name."
  type        = string
}

variable "quota" {
  description = "Share size in GB."
  type        = number
  default     = 100
}

variable "enabled_protocol" {
  description = "SMB or NFS."
  type        = string
  default     = "SMB"
}
