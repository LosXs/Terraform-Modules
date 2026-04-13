output "id" {
  description = "The ID of the Key Vault secret (versionless)."
  value       = azurerm_key_vault_secret.this.id
}

output "name" {
  description = "The name of the Key Vault secret."
  value       = azurerm_key_vault_secret.this.name
}

output "version" {
  description = "The current version of the secret (sensitive in some contexts; not the secret value)."
  value       = azurerm_key_vault_secret.this.version
}

output "resource_id" {
  description = "The versioned resource ID of the secret instance."
  value       = azurerm_key_vault_secret.this.resource_id
}
