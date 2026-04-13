output "id" {
  description = "User-assigned identity resource ID."
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "Identity name."
  value       = azurerm_user_assigned_identity.this.name
}

output "principal_id" {
  description = "Service principal object ID for RBAC."
  value       = azurerm_user_assigned_identity.this.principal_id
}

output "client_id" {
  description = "Client ID for applications."
  value       = azurerm_user_assigned_identity.this.client_id
}

output "user_assigned_identity" {
  description = "Identity resource object."
  value       = azurerm_user_assigned_identity.this
}
