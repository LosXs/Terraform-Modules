output "id" {
  description = "Linux web app resource ID."
  value       = azurerm_linux_web_app.this.id
}

output "name" {
  description = "Linux web app name."
  value       = azurerm_linux_web_app.this.name
}

output "default_hostname" {
  description = "Default hostname."
  value       = azurerm_linux_web_app.this.default_hostname
}

output "linux_web_app" {
  description = "Linux web app resource object."
  value       = azurerm_linux_web_app.this
}
