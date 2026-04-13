output "id" {
  description = "Storage share ID."
  value       = azurerm_storage_share.this.id
}

output "name" {
  description = "Storage share name."
  value       = azurerm_storage_share.this.name
}

output "storage_share" {
  description = "Storage share resource object."
  value       = azurerm_storage_share.this
}
