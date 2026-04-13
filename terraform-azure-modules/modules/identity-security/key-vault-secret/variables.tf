# Key Vault secrets do not support diagnostic settings; compliance is inherited from the Key Vault and resource group.

variable "key_vault_id" {
  description = "Azure resource ID of the Key Vault that will store this secret."
  type        = string
}

variable "name" {
  description = "Name of the secret within the Key Vault."
  type        = string
}

variable "value" {
  description = "Secret value."
  type        = string
  sensitive   = true
}

variable "content_type" {
  description = "Optional content type metadata (e.g. application/json)."
  type        = string
  default     = null
}

variable "tags" {
  description = "Must be the output of the _shared/tags module to ensure compliance with organisational tagging. Applied when the provider/API supports tags on secrets."
  type        = map(string)
}
