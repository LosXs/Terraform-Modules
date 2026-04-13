output "id" {
  description = "Linux function app resource ID."
  value       = azurerm_linux_function_app.this.id
}

output "name" {
  description = "Function app name."
  value       = azurerm_linux_function_app.this.name
}

output "default_hostname" {
  description = "Default hostname."
  value       = azurerm_linux_function_app.this.default_hostname
}

output "function_app" {
  description = "Linux function app resource object."
  value       = azurerm_linux_function_app.this
}
