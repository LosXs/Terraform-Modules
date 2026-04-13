output "id" {
  description = "Metric alert ID."
  value       = azurerm_monitor_metric_alert.this.id
}

output "name" {
  description = "Metric alert name."
  value       = azurerm_monitor_metric_alert.this.name
}

output "metric_alert" {
  description = "Metric alert resource object."
  value       = azurerm_monitor_metric_alert.this
}
