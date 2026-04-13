output "id" {
  description = "The Azure resource ID of the diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.this.id
}

output "name" {
  description = "The name of the diagnostic setting."
  value       = azurerm_monitor_diagnostic_setting.this.name
}
