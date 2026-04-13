variable "key_vault_id" {
  description = "Key Vault resource ID."
  type        = string
}

variable "name" {
  description = "Key name within the vault."
  type        = string
}

variable "key_type" {
  description = "RSA or EC."
  type        = string
  default     = "RSA"

  validation {
    condition     = contains(["RSA", "EC"], var.key_type)
    error_message = "key_type must be RSA or EC."
  }
}

variable "key_size" {
  description = "RSA key size in bits (e.g. 2048, 3072)."
  type        = number
  default     = 2048
}

variable "key_opts" {
  description = "Permitted key operations."
  type        = list(string)
  default     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
}

variable "tags" {
  description = "Must be the output of the _shared/tags module."
  type        = map(string)
}
