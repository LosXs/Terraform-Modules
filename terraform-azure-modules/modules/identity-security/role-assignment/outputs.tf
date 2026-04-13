output "id" {
  description = "The role assignment ID (stable identifier for the assignment)."
  value       = azurerm_role_assignment.this.id
}

output "name" {
  description = "A UUID-style name for the role assignment (Azure-assigned)."
  value       = azurerm_role_assignment.this.name
}

output "principal_id" {
  description = "The principal ID this assignment applies to."
  value       = azurerm_role_assignment.this.principal_id
}

output "role_assignment" {
  description = "The role assignment resource (non-sensitive attributes)."
  value       = azurerm_role_assignment.this
}
