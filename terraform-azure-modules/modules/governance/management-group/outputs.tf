output "id" {
  description = "The management group resource ID."
  value       = azurerm_management_group.this.id
}

output "name" {
  description = "The management group name (ID)."
  value       = azurerm_management_group.this.name
}

output "management_group" {
  description = "The management group resource object."
  value       = azurerm_management_group.this
}
