output "id" {
  description = "Container app resource ID."
  value       = azurerm_container_app.this.id
}

output "name" {
  description = "Container app name."
  value       = azurerm_container_app.this.name
}

output "container_app" {
  description = "Container app resource object."
  value       = azurerm_container_app.this
}
