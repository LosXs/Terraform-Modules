output "id" {
  description = "The policy assignment ID."
  value       = azurerm_resource_group_policy_assignment.this.id
}

output "name" {
  description = "The policy assignment name."
  value       = azurerm_resource_group_policy_assignment.this.name
}

output "policy_assignment" {
  description = "The policy assignment resource object."
  value       = azurerm_resource_group_policy_assignment.this
}
