variable "resource_group_name" {
  description = "Resource group for the AKS cluster."
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
  description = "AKS cluster name."
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix for the API server FQDN."
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version (null for default)."
  type        = string
  default     = null
}

variable "node_count" {
  description = "Initial node count for default pool."
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for default node pool."
  type        = string
  default     = "Standard_DS2_v2"
}

variable "network_plugin" {
  description = "CNI plugin (azure or kubenet)."
  type        = string
  default     = "azure"
}

variable "diagnostics_settings" {
  description = "When non-null, diagnostic setting for the cluster."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
