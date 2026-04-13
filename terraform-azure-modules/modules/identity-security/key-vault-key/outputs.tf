output "id" {
  description = "Key Vault key ID."
  value       = azurerm_key_vault_key.this.id
}

output "name" {
  description = "Key name."
  value       = azurerm_key_vault_key.this.name
}

output "version" {
  description = "Key version."
  value       = azurerm_key_vault_key.this.version
}

output "key_vault_key" {
  description = "Key resource object."
  value       = azurerm_key_vault_key.this
}
