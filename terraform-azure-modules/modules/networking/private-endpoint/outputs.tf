output "id" {
  description = "Private endpoint resource ID."
  value       = azurerm_private_endpoint.this.id
}

output "name" {
  description = "Private endpoint name."
  value       = azurerm_private_endpoint.this.name
}

output "private_endpoint" {
  description = "Private endpoint resource object."
  value       = azurerm_private_endpoint.this
}
