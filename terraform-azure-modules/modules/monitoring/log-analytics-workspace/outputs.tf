output "id" {
  description = "The Azure resource ID of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "The name of the Log Analytics workspace."
  value       = azurerm_log_analytics_workspace.this.name
}

output "workspace_id" {
  description = "The Workspace (customer) ID used by agents and some diagnostic destinations."
  value       = azurerm_log_analytics_workspace.this.workspace_id
}

output "log_analytics_workspace" {
  description = "The Log Analytics workspace resource object (non-sensitive attributes)."
  value       = azurerm_log_analytics_workspace.this
}
