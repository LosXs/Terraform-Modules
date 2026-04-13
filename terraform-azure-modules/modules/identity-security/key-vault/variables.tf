variable "resource_group_name" {
  description = "Name of the resource group that will contain the Key Vault."
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
  description = "Must be the output of the _shared/tags module to ensure compliance with Azure Policy 'Resource Group - Required Tags'. Must include all six mandatory organisational tags."
  type        = map(string)
}

variable "name" {
  description = "Globally unique Key Vault name (3–24 chars; alphanumeric and hyphens). Typically from _shared/naming.key_vault."
  type        = string
}

variable "tenant_id" {
  description = "Azure AD tenant ID for the Key Vault (pass the subscription tenant, e.g. from data.azurerm_client_config.current.tenant_id in the root module)."
  type        = string
}

variable "sku_name" {
  description = "SKU for the Key Vault (standard or premium)."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], lower(var.sku_name))
    error_message = "sku_name must be \"standard\" or \"premium\"."
  }
}

variable "rbac_authorization_enabled" {
  description = "When true, use Azure RBAC for data plane access (recommended). When false, use access policies (legacy)."
  type        = bool
  default     = true
}

variable "purge_protection_enabled" {
  description = "Enable purge protection (recommended for production)."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention in days (7–90)."
  type        = number
  default     = 90

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "public_network_access_enabled" {
  description = "Whether the Key Vault is reachable from public networks. Prefer false with private endpoints for sensitive workloads."
  type        = bool
  default     = true
}

variable "network_acls" {
  description = "When non-null, configures Key Vault network ACLs (default_action, bypass, optional ip_rules and virtual_network_subnet_ids)."
  type = object({
    default_action             = string
    bypass                     = string
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  default = null
}

variable "diagnostics_settings" {
  description = "When non-null, creates a diagnostic setting on this Key Vault to the given Log Analytics workspace."
  type = object({
    name                       = optional(string)
    log_analytics_workspace_id = string
    logs_enabled               = optional(bool, true)
    metrics_enabled            = optional(bool, true)
  })
  default = null
}
