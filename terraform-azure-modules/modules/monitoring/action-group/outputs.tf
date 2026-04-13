output "id" {
  description = "Action group resource ID."
  value       = azurerm_monitor_action_group.this.id
}

output "name" {
  description = "Action group name."
  value       = azurerm_monitor_action_group.this.name
}

output "action_group" {
  description = "Action group resource object."
  value       = azurerm_monitor_action_group.this
}
