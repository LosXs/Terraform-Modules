output "id" {
  description = "The Azure resource ID of the Key Vault."
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "The name of the Key Vault."
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "The URI of the Key Vault."
  value       = azurerm_key_vault.this.vault_uri
}

output "key_vault" {
  description = "The Key Vault resource object (non-sensitive attributes)."
  value       = azurerm_key_vault.this
}
