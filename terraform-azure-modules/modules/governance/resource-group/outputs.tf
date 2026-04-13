output "id" {
  description = "The Azure resource ID of the resource group."
  value       = azurerm_resource_group.this.id
}

output "name" {
  description = "The name of the resource group."
  value       = azurerm_resource_group.this.name
}

output "resource_group" {
  description = "The resource group object (non-sensitive attributes)."
  value       = azurerm_resource_group.this
}
