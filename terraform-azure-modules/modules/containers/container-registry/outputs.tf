output "id" {
  description = "Container registry resource ID."
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Registry name."
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Login server URL."
  value       = azurerm_container_registry.this.login_server
}

output "container_registry" {
  description = "ACR resource object."
  value       = azurerm_container_registry.this
}
