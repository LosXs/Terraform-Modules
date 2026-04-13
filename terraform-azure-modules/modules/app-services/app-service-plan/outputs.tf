output "id" {
  description = "App Service plan resource ID."
  value       = azurerm_service_plan.this.id
}

output "name" {
  description = "App Service plan name."
  value       = azurerm_service_plan.this.name
}

output "service_plan" {
  description = "Service plan resource object."
  value       = azurerm_service_plan.this
}
