output "id" {
  description = "Windows web app resource ID."
  value       = azurerm_windows_web_app.this.id
}

output "name" {
  description = "Windows web app name."
  value       = azurerm_windows_web_app.this.name
}

output "default_hostname" {
  description = "Default hostname."
  value       = azurerm_windows_web_app.this.default_hostname
}

output "windows_web_app" {
  description = "Windows web app resource object."
  value       = azurerm_windows_web_app.this
}
