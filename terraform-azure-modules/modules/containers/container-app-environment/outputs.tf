output "id" {
  description = "Container App Environment resource ID."
  value       = azurerm_container_app_environment.this.id
}

output "name" {
  description = "Environment name."
  value       = azurerm_container_app_environment.this.name
}

output "container_app_environment" {
  description = "Environment resource object."
  value       = azurerm_container_app_environment.this
}
